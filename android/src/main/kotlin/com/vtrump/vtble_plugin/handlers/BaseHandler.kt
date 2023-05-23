package com.vtrump.vtble_plugin.handlers

import android.os.Handler
import android.os.Looper
import com.vtrump.vtble_plugin.PluginProtoModel
import com.vtrump.vtble.VTDevice
import com.vtrump.vtble.VTDeviceSmv
import io.flutter.plugin.common.EventChannel

/**
 * @author timzhang
 * @date 2023/2/16
 */
abstract class BaseHandler(private val handler: Handler) : EventChannel.StreamHandler {
    protected var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        events?.let {
            eventSink = it
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    fun deviceEventConvert(
        type: String, vtDevice: VTDevice? = null
    ): PluginProtoModel.DeviceEvent {
        val builder = PluginProtoModel.DeviceEvent.newBuilder().setType(type)
        vtDevice?.let {
            val deviceInfoBuilder = PluginProtoModel.DeviceInfo.newBuilder()
                .setName(if (vtDevice.name == null) "" else vtDevice.name)
                .setFirmWareVersion(if (vtDevice.firmWareVersion == null) "" else vtDevice.firmWareVersion)
                .setUuid(if (vtDevice.btDevice.address == null) "" else vtDevice.btDevice.address)
                .setIsDualMotor(if (it is VTDeviceSmv) it.isMotor2Support else false)
                .setIsDualLed(if (it is VTDeviceSmv) it.isDualLed else false)
            if (vtDevice.modelIdentifer != null) {
                deviceInfoBuilder.setIdentifier(
                    PluginProtoModel.ScanDeviceType.newBuilder()
                        .setProtocol(vtDevice.modelIdentifer.protocolVersion)
                        .setDeviceType(vtDevice.modelIdentifer.deviceType)
                        .setSubType(vtDevice.modelIdentifer.deviceSubType)
                        .setVendor(vtDevice.modelIdentifer.vendor)
                )
            }
            builder.setDeviceInfo(deviceInfoBuilder)
        }
        return builder.build()
    }

    /**
     * 判断当前线程是否是主线程
     */
    private fun isMainThread(): Boolean {
        return Looper.myLooper() === Looper.getMainLooper()
    }

    /**
     * 将目标代码快运行在主线程中
     */
    protected fun runOnMainThread(runnable: Runnable) {
        if (isMainThread()) {
            runnable.run()
        } else {
            handler.post(runnable)
        }
    }

    /**
     * 向观察者们发送成功消息
     */
    fun sendSuccessMsgToEventChannel(type: String, vtDevice: VTDevice? = null) {
        val msg = deviceEventConvert(type, vtDevice)
        eventSink?.let {
            runOnMainThread {
                it.success(msg.toByteArray())
            }
        }
    }

    /**
     * 向观察者们轮询发送失败消息
     */
    fun sendFailMsgToEventChannel(errCode: String, errMsg: String, errDetail: Any) {
        eventSink?.let {
            runOnMainThread {
                it.error(errCode, errMsg, errDetail)
            }
        }
    }
}