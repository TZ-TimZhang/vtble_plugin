package com.vtrump.vtble_plugin.handlers

import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.location.LocationManager
import android.os.Build
import android.os.Handler
import com.vtrump.vtble_plugin.BleManager
import com.vtrump.vtble_plugin.BleStatus
import com.vtrump.vtble_plugin.PluginProtoModel
import io.flutter.plugin.common.EventChannel
import java.lang.ref.WeakReference

/**
 * @author timzhang
 * @date 2023/2/16
 */
class BleStatusHandler(
    handler: Handler, val context: Context, val bleManager: WeakReference<BleManager>
) : BaseHandler(handler) {
    private var lastBleStatus: BleStatus? = null

    private val mReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            val action: String? = intent.action
            var curBleStatus: BleStatus? = null
            if (BluetoothAdapter.ACTION_STATE_CHANGED == action) {
                val state: Int = intent.getIntExtra(
                    BluetoothAdapter.EXTRA_STATE, BluetoothAdapter.ERROR
                )
                when (state) {
                    BluetoothAdapter.STATE_OFF -> {
                        curBleStatus = bleManager.get()?.checkBleStatus()
                    }
                    BluetoothAdapter.STATE_ON -> {
                        curBleStatus = bleManager.get()?.checkBleStatus()
                    }
                }
            } else if (LocationManager.PROVIDERS_CHANGED_ACTION == action || LocationManager.MODE_CHANGED_ACTION == action) {
                curBleStatus = bleManager.get()?.checkBleStatus()
            }
            if (curBleStatus != null && lastBleStatus != curBleStatus) {
                lastBleStatus = curBleStatus
                sendSuccessMsgToEventChannel(curBleStatus)
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        super.onListen(arguments, events)
        val filter = IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)
        filter.addAction(LocationManager.PROVIDERS_CHANGED_ACTION)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            filter.addAction(LocationManager.MODE_CHANGED_ACTION)
        }
        context.registerReceiver(mReceiver, filter)
        lastBleStatus = bleManager.get()?.checkBleStatus()
        lastBleStatus?.let { sendSuccessMsgToEventChannel(it) }
    }

    override fun onCancel(arguments: Any?) {
        super.onCancel(arguments)
        context.unregisterReceiver(mReceiver);
    }

    fun sendBleStatus(bleStatus: BleStatus) {
        if (lastBleStatus != bleStatus) {
            lastBleStatus = bleStatus
            sendSuccessMsgToEventChannel(bleStatus)
        }
    }

    /**
     * 向观察者们发送成功消息
     */
    fun sendSuccessMsgToEventChannel(bleStatus: BleStatus) {
        val msg = PluginProtoModel.BleStatusInfo.newBuilder().setStatus(bleStatus.code).build()
        eventSink?.let {
            runOnMainThread {
                it.success(msg.toByteArray())
            }
        }
    }

}