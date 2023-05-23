package com.vtrump.vtble_plugin

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** VtblePlugin */
class VtblePlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var activity: Activity? = null

    private lateinit var bleManager: BleManager

    private var permissionResult: Result? = null
    private var openBleResult: Result? = null
    private var openLocationResult: Result? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vtble_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        bleManager = BleManager(context, binaryMessenger)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            // Android专属
            "moveToBack" -> {
                activity?.moveTaskToBack(true)
            }
            // 设置是否开启日志
            "setLogEnable" -> {
                val isLogEnable = call.arguments as Boolean
                BleManager.setLogEnable(isLogEnable)
                result.success(null)
            }
            // 检查蓝牙状态
            "checkBleState" -> {
                val status = bleManager.checkBleStatus()
                result.success(
                    PluginProtoModel.BleStatusInfo.newBuilder().setStatus(status.code).build()
                        .toByteArray()
                )
            }
            // 请求相关权限
            "applyPermission" -> {
                permissionResult = result
                applyPermission()
            }
            // 打开蓝牙
            "openBluetoothService" -> {
                // 开启蓝牙功能
                openBleResult = result
                openBluetoothService()
            }
            // 打开定位
            "openLocationService" -> {
                // 开启蓝牙定位功能
                openLocationResult = result
                openLocationService()
            }
            // 设置key
            "setKey" -> {
                bleManager.setKey(call.arguments as String)
                result.success(null)
            }
            // 开始扫描
            "startScan" -> {
                try {
                    val scanParams =
                        PluginProtoModel.ScanForDevicesRequest.parseFrom(call.arguments as ByteArray)
                    bleManager.startScan(activity, scanParams, result)
                } catch (e: Exception) {
                    result.error("startScan_error", e.message, null)
                }
            }
            // 停止扫描
            "stopScan" -> {
                bleManager.stopScan()
                result.success(null)
            }
            // 是否扫描中
            "isScanning" -> {
                result.success(bleManager.isScanning())
            }
            // 连接
            "connect" -> {
                try {
                    val connectRequest =
                        PluginProtoModel.ConnectRequest.parseFrom(call.arguments as ByteArray)
                    bleManager.connect(connectRequest.uuid)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("connect_error", e.message, null)
                }
            }
            // 是否已连接
            "isConnected" -> {
                result.success(bleManager.isConnected())
            }
            // 写入震动数据
            "writeMotor" -> {
//                val motorData =
//                    PluginProtoModel.MotorDataRequest.parseFrom(call.arguments as ByteArray)
//                bleManager.writeMotor(motorData.value.toByte())
                bleManager.writeMotor((call.arguments as Int).toByte())
                result.success(null)
            }

            "stopVibrate" -> {
                bleManager.stopVibrate()
                result.success(null)
            }

            "writeMotorLED" -> {
                val motor = call.argument<Int>("motor")
                val led = call.argument<Int>("led")
                bleManager.writeMotorLED((motor ?: 0).toByte(), (led ?: 0).toByte())
                result.success(null)
            }

            "writeDualMotorLED" -> {
                val motor1 = call.argument<Int>("motor1")
                val motor2 = call.argument<Int>("motor2")
                val led = call.argument<Int>("led")
                bleManager.writeDualMotorLED(
                    (motor1 ?: 0).toByte(), (motor2 ?: 0).toByte(), (led ?: 0).toByte()
                )
                result.success(null)
            }

            "writeDualMotorDualLED" -> {
                val motor1 = call.argument<Int>("motor1")
                val motor2 = call.argument<Int>("motor2")
                val led1 = call.argument<Int>("led1")
                val led2 = call.argument<Int>("led2")
                bleManager.writeDualMotorDualLED(
                    (motor1 ?: 0).toByte(),
                    (motor2 ?: 0).toByte(),
                    (led1 ?: 0).toByte(),
                    (led2 ?: 0).toByte()
                )
                result.success(null)
            }

            "writeLed" -> {
                bleManager.writeLed((call.arguments as Int).toByte())
                result.success(null)
            }

            "writeCloseLed" -> {
                bleManager.writeCloseLed()
                result.success(null)
            }

            "setCommandInterval" -> {
                val interval = call.argument<Int>("interval")
                interval?.let {
                    bleManager.setCommandInterval(it)
                }
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    /**
     * 申请打开位置定位功能
     */
    private fun openLocationService() {
        activity?.startActivityForResult(
            Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS), REQUEST_CODE_LOCATION_SETTINGS
        )
    }

    /**
     * 申请打开蓝牙
     */
    private fun openBluetoothService() {
        //intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);//如果试图从非activity的非正常途径启动一个activity，比如从一个service中启动一个activity，则intent必须要添加FLAG_ACTIVITY_NEW_TASK标记,但是加了的话就不会等待返回结果
        activity?.startActivityForResult(
            Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE), REQUEST_CODE_OPEN_BLUETOOTH
        ) //此方法用来打开一个新的activity来让让用户确认是否要打开蓝牙
    }

    /**
     * 申请定蓝牙权限
     */
    private fun applyPermission() {
        val permissions = mutableListOf<String>()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
                permissions.add(Manifest.permission.ACCESS_FINE_LOCATION)
                permissions.add(Manifest.permission.ACCESS_COARSE_LOCATION)
            } else if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S /* pre Android 12 */) {
                permissions.add(Manifest.permission.ACCESS_FINE_LOCATION)
            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                permissions.add(Manifest.permission.BLUETOOTH_SCAN)
                permissions.add(Manifest.permission.BLUETOOTH_CONNECT)
            }
        }

        if (permissions.isEmpty()) {
            permissionResult?.success(true)
        } else {
            ActivityCompat.requestPermissions(
                activity!!, permissions.toTypedArray(), REQUEST_CODE_PERMISSION
            )
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        bleManager.release()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        bleManager.setActivity(activity!!)
        binding.addActivityResultListener { requestCode, resultCode, data ->
            when (requestCode) {
                REQUEST_CODE_LOCATION_SETTINGS -> {
                    openLocationResult?.success(bleManager.isLocationEnable())
                    return@addActivityResultListener true
                }

                REQUEST_CODE_OPEN_BLUETOOTH -> {
                    openBleResult?.success(resultCode == Activity.RESULT_OK)
                    return@addActivityResultListener true
                }
            }
            return@addActivityResultListener false
        }
        binding.addRequestPermissionsResultListener { requestCode, permissions, grantResults ->
            var isAllow = grantResults.isNotEmpty()
            for (element in grantResults) {
                if (element != PackageManager.PERMISSION_GRANTED) {
                    isAllow = false
                    break
                }
            }
            if (requestCode == REQUEST_CODE_PERMISSION) {
                permissionResult?.success(isAllow)
                bleManager.checkBleStatusAndNotify()
                return@addRequestPermissionsResultListener true
            }
            return@addRequestPermissionsResultListener false
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        bleManager.setActivity(activity!!)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    companion object {
        private const val REQUEST_CODE_OPEN_BLUETOOTH = 1001 //开启蓝牙服务的requestCode

        private const val REQUEST_CODE_LOCATION_SETTINGS = 1002 //申请蓝牙权限的requestCode

        private const val REQUEST_CODE_PERMISSION = 1003
    }
}
