package com.vtrump.vtble_plugin

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.core.content.ContextCompat
import com.vtrump.vtble_plugin.handlers.*
import com.vtrump.vtble.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference

/**
 * @author timzhang
 * @date 2023/2/16
 */
class BleManager(
    private val mContext: Context, private val binaryMessenger: BinaryMessenger
) {
    private var mActivity: Activity? = null
    private lateinit var mBleManager: VTDeviceManager
    private lateinit var mScanConfig: ScanConfig
    private var mIsScanning = false
    private var mDevice: VTDeviceSmv? = null

    private lateinit var scanEventChannel: EventChannel
    private lateinit var connectEventChannel: EventChannel
    private lateinit var statusEventChannel: EventChannel
    private lateinit var bleStatusEventChannel: EventChannel

    private lateinit var scanHandler: ScanHandler
    private lateinit var connectHandler: ConnectHandler
    private lateinit var statusHandler: StatusHandler
    private lateinit var bleStatusHandler: BleStatusHandler

    private val mHandler: Handler = Handler(Looper.getMainLooper())

    init {
        init()
    }

    private fun logE(msg: String) {
        if (isLogEnable) {
            Log.e(TAG, msg)
        }
    }

    private fun logD(msg: String) {
        if (isLogEnable) {
            Log.d(TAG, msg)
        }
    }


    private fun init() {
        scanEventChannel = EventChannel(binaryMessenger, "ble_plugin_scan")
        connectEventChannel = EventChannel(binaryMessenger, "ble_plugin_connect")
        statusEventChannel = EventChannel(binaryMessenger, "ble_plugin_status")
        bleStatusEventChannel = EventChannel(binaryMessenger, "ble_plugin_ble_status")

        scanHandler = ScanHandler(mHandler)
        connectHandler = ConnectHandler(mHandler)
        statusHandler = StatusHandler(mHandler)
        bleStatusHandler =
            BleStatusHandler(mHandler, context = mContext, bleManager = WeakReference(this))

        scanEventChannel.setStreamHandler(scanHandler)
        connectEventChannel.setStreamHandler(connectHandler)
        statusEventChannel.setStreamHandler(statusHandler)

        bleStatusEventChannel.setStreamHandler(bleStatusHandler)

        mBleManager = VTDeviceManager.getInstance()
        mBleManager.setDeviceManagerListener(object : VTDeviceManager.VTDeviceManagerListener {
            override fun onBleStatusChange(b: Boolean) {
                logE("onBleStatusChange: $b")
                statusHandler.sendSuccessMsgToEventChannel(if (b) "connected" else "disconnected")
            }

            override fun onInited() {
                statusHandler.sendSuccessMsgToEventChannel("init")
            }

            override fun onDeviceDiscovered(vtDevice: VTDevice, i: Int) {
                logD("onDeviceDiscovered: ")
                if (vtDevice is VTDeviceToy) {
                    logD("vtDevice.name ${vtDevice.name}, vtDevice.firmWareVersion: ${vtDevice.firmWareVersion}, vtDevice.btDevice.address: ${vtDevice.btDevice.address}")
                    scanHandler.sendSuccessMsgToEventChannel("discovered", vtDevice)
                }
            }

            override fun onDeviceConnected(vtDevice: VTDevice) { //BLE_DEVICE_CONNECTED
                mDevice = vtDevice as VTDeviceSmv
                mIsScanning = false
                logD("onDeviceConnected: ${mDevice!!.status}")
                logD("onDeviceConnected: name: ${vtDevice.name}, mac: ${vtDevice.btDevice.address}, firmWareVersion: ${vtDevice.firmWareVersion}, modelIdentifer: ${vtDevice.modelIdentifer}")
                connectHandler.sendSuccessMsgToEventChannel("connected", vtDevice)
            }

            override fun onDeviceDisconnected(vtDevice: VTDevice) { //BLE_DISCONNECTED
                mDevice = vtDevice as VTDeviceSmv
                mIsScanning = false
                logD("onDeviceDisconnected: name: ${vtDevice.name}, mac: ${vtDevice.btDevice.address}, firmWareVersion: ${vtDevice.firmWareVersion}, modelIdentifer: ${vtDevice.modelIdentifer}")
                connectHandler.sendSuccessMsgToEventChannel("disconnected", vtDevice)
            }

            override fun onDeviceServiceDiscovered(vtDevice: VTDevice) { //BLE_SERVICES_DISCOVERED
                logD("onDeviceServiceDiscovered: name: ${vtDevice.name}, mac: ${vtDevice.btDevice.address}, firmWareVersion: ${vtDevice.firmWareVersion}, modelIdentifer: ${vtDevice.modelIdentifer}")
                mDevice = vtDevice as VTDeviceSmv
                setDeviceListener()
//                mDevice!!.writeDualMotorLED(0.toByte(), 0.toByte(), 80.toByte())
                connectHandler.sendSuccessMsgToEventChannel("serviceDiscovered", vtDevice)
            }

            override fun onScanStop() {
                logD("onScanStop: ")
                mIsScanning = false
                scanHandler.sendSuccessMsgToEventChannel("stop")
            }

            override fun onScanTimeOut() {
                logD("onScanTimeOut")
                scanHandler.sendSuccessMsgToEventChannel("timeOut")
            }
        })
        mBleManager.initBle(mContext)
        mScanConfig = ScanConfig()
        mBleManager.setScanConfig(mScanConfig)
    }

    fun setActivity(activity: Activity) {
        mActivity = activity
    }

    fun release() {
        logD("release.")
        mActivity = null
        mBleManager.releaseBleManager()
    }

    fun setDeviceListener() {
        mDevice?.setSmvDataListener(object : VTDeviceSmv.VTDeviceSmvListener() {
            override fun onRssiReceived(p0: Int) {
                super.onRssiReceived(p0)
                logD("onRssiReceived: $p0")
            }
        })
        mDevice?.setToyDataListener(object : VTDeviceToy.VTDeviceToyListener() {
            override fun onSensorDataReceived(p0: Float) {
                super.onSensorDataReceived(p0)
                logD("onSensorDataReceived: $p0")
            }

            override fun onGSensorDataReceived(p0: ShortArray?) {
                super.onGSensorDataReceived(p0)
                logD("onGSensorDataReceived: $p0")
            }

            override fun onGSensorStepsReceived(p0: Int) {
                super.onGSensorStepsReceived(p0)
                logD("onGSensorStepsReceived: $p0")
            }

            override fun onTemperatureDataReceived(p0: Int) {
                super.onTemperatureDataReceived(p0)
                logD("onTemperatureDataReceived: $p0")
            }

            override fun onDataReceived(p0: String?) {
                super.onDataReceived(p0)
                logD("onDataReceived: $p0")
            }
        })
    }


    /// 工具函数

    /**
     * 检查需要使用蓝牙缺什么权限和功能
     */
    fun checkBlueLackWhat(): List<Int> {
        val lackArray: MutableList<Int> = ArrayList(3)
        if (!checkHaveLocalPermission()) //如果没有开启定位权限
            lackArray.add(0)
        if (!isLocationEnable()) //如果没有开启定位功能
            lackArray.add(1)
        if (!mBleManager.isBlueToothEnabled) //如果没有打开蓝牙
            lackArray.add(2)
        if (!checkHaveBluePermission()) //如果没有授予蓝牙权限
            lackArray.add(3)
        return lackArray
    }

    fun checkBleStatus(): BleStatus {
        var bleStatus = BleStatus.READY
        if (!checkPermission()) {
            bleStatus = BleStatus.UNAUTHORIZED
        } else if (!isLocationEnable()) {
            bleStatus = BleStatus.LOCATION_SERVICES_DISABLED
        } else if (!mBleManager.isBlueToothEnabled) {
            bleStatus = BleStatus.POWERED_OFF
        }
        return bleStatus
    }

    fun checkBleStatusAndNotify() {
        val bleStatus = checkBleStatus()
        bleStatusHandler.sendBleStatus(bleStatus)
    }

    fun checkPermission(): Boolean {
//        val targetSdkVersion =
//            mContext.packageManager.getApplicationInfo(mContext.packageName, 0).targetSdkVersion
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true
        }
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            return ContextCompat.checkSelfPermission(
                mContext, Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED && ContextCompat.checkSelfPermission(
                mContext, Manifest.permission.ACCESS_COARSE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        }
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S /* pre Android 12 */) {
            // Since API 29 (Android 10) only ACCESS_FINE_LOCATION allows for getting scan results
            return ContextCompat.checkSelfPermission(
                mContext, Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        }
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            ContextCompat.checkSelfPermission(
                mContext, Manifest.permission.BLUETOOTH_SCAN
            ) == PackageManager.PERMISSION_GRANTED && ContextCompat.checkSelfPermission(
                mContext, Manifest.permission.BLUETOOTH_CONNECT
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }


    /**
     * 判断用户是否有授予蓝牙权限,适配android12
     */
    private fun checkHaveBluePermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) ContextCompat.checkSelfPermission(
            mContext, Manifest.permission.BLUETOOTH_SCAN
        ) == PackageManager.PERMISSION_GRANTED && ContextCompat.checkSelfPermission(
            mContext, Manifest.permission.BLUETOOTH_CONNECT
        ) == PackageManager.PERMISSION_GRANTED else true
    }

    /**
     * 判断是否已经打开位置定位的功能
     */
    fun isLocationEnable(): Boolean {
        val locationManager: LocationManager =
            mContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val networkProvider: Boolean =
            locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
        val gpsProvider: Boolean = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        return networkProvider || gpsProvider
    }

    /**
     * 判断用户是否有授予定位权限
     */
    private fun checkHaveLocalPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) ContextCompat.checkSelfPermission(
            mContext, Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED && ContextCompat.checkSelfPermission(
            mContext, Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED else ContextCompat.checkSelfPermission(
            mContext, Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
    }

    /// End 工具函数


    fun getDevice(): VTDeviceSmv? {
        return mDevice
    }

    fun isBlueToothEnabled(): Boolean {
        return mBleManager.isBlueToothEnabled
    }

    fun connect(mac: String) {
        mBleManager.startConn(mac)
    }

    fun startScan(
        activity: Activity?,
        scanParams: PluginProtoModel.ScanForDevicesRequest,
        result: MethodChannel.Result
    ) {
        logE("startScan: mIsScanning： $mIsScanning ，${isConnected()}")
        if (!mBleManager.isBlueToothEnabled) {
            logE("isBlueToothEnabled: false")
            result.error("blueToothDisabled", "BlueTooth is disabled", null)
            return
        }
        if (!mBleManager.isInit) {
            logE("mBleManager.isInit(): ${mBleManager.isInit}")
            mBleManager.initBle(activity)
            result.error("bleManagerNotInit", "BleManager is not init", null)
            return
        }
        if (!mIsScanning) {
            if (!isConnected()) {
                val modelIdentifierList = scanParams.scanDeviceTypesList.map {
                    VTModelIdentifier(
                        it.protocol.toByte(),
                        it.deviceType.toByte(),
                        it.subType.toByte(),
                        it.vendor.toByte()
                    )
                }
                mScanConfig.isScanOnly = scanParams.scanConfig.scanOnly
                mScanConfig.mac = scanParams.scanConfig.mac
                mBleManager.startScan(
                    scanParams.timeoutInSeconds,
                    modelIdentifierList as java.util.ArrayList<VTModelIdentifier>
                )
            }
            mIsScanning = true
            logD("onScanStart")
            scanHandler.sendSuccessMsgToEventChannel("start")
        }
        result.success(null)
    }

    fun isGpsEnable(activity: Activity): Boolean {
        val locationManager = activity.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val gps = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        val network = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
        return gps || network
    }

    open fun writeMotor(value: Byte) {
        logE("writeMotor: $value")
        getDevice()?.writeMotor(value)
    }

    open fun writeMotorLED(value: Byte, led: Byte) {
        logE("writeMotorLED: $value, $led")
        getDevice()?.writeMotorLED(value, led)
    }

    open fun writeDualMotorLED(value1: Byte, value2: Byte, led: Byte) {
        logE("writeDualMotorLED: $value1, $value2, $led")
        getDevice()?.writeDualMotorLED(value1, value2, led)
    }

    open fun writeDualMotorDualLED(value1: Byte, value2: Byte, led1: Byte, led2: Byte) {
        logE("writeDualMotorDualLED: $value1, $value2, $led1, $led2")
        getDevice()?.writeDualMotorDualLED(value1, value2, led1, led2)
    }

    open fun writeLed(led: Byte) {
        logE("writeLed: $led")
        getDevice()?.writeLed(led)
    }

    open fun writeDualLed(led1: Byte, led2: Byte) {
        logE("writeDualLed: $led1, $led2")
        getDevice()?.writeDualLed(led1, led2)
    }

    open fun writeCloseLed() {
        logE("writeCloseLed")
        getDevice()?.writeCloseLed()
        getDevice()?.isMotor2Support
    }

    open fun stopVibrate() {
        getDevice()?.stopVibe()
    }

    fun stopScan() {
        mBleManager.stopScan()
    }

    fun setCommandInterval(interval: Int) {
        getDevice()?.setCommandInterval(interval)
    }

    fun setScanning(scanning: Boolean) {
        mIsScanning = scanning
    }

    fun isScanning(): Boolean {
        return mIsScanning
    }

    fun isConnected(): Boolean {
        return mDevice != null && (mDevice!!.status == VTDevice.VTDeviceStatus.STATUS_CONNECTED || mDevice!!.status == VTDevice.VTDeviceStatus.STATUS_SERVICE_DISCOVERED)
    }

    var toyListener: VTDeviceToy.VTDeviceToyListener = object : VTDeviceToy.VTDeviceToyListener() {
        override fun onGSensorDataReceived(values: ShortArray) {
            super.onGSensorDataReceived(values)
            val x = values[0].toInt() // x-axis acceleration
            val y = values[1].toInt() // y-axis acceleration
            val z = values[2].toInt() // z-axis acceleration
        }

        override fun onDataReceived(s: String) {
            super.onDataReceived(s)
        }
    }

    fun setKey(key: String) {
        mBleManager.key = key
    }

    fun setCurMac(curMac: String?) {
        logD("setCurMac: $curMac")
        mScanConfig.mac = curMac
        mBleManager.setScanConfig(mScanConfig)
    }

    fun continueScan(c: Boolean) {
//        mScanConfig.setContinuScan(c);
        mBleManager.setScanConfig(mScanConfig)
    }

    fun setScanOnly(only: Boolean) {
        mScanConfig.isScanOnly = only
        mBleManager.setScanConfig(mScanConfig)
    }

    fun disConnect() {
        mBleManager.disconnectAll()
        mBleManager.discoveredDeviceList.clear()
    }

    companion object {
        private val TAG = BleManager::class.java.simpleName

        private var isLogEnable = true

        fun setLogEnable(isEnable: Boolean) {
            isLogEnable = isEnable
        }

        const val INVALID_NAME = ""

        const val VT_VTOY_SMV07: Byte = 0x00 //SmartCell,Magic Dante/Magic Candy
        const val VT_VTOY_SMV06: Byte = 0x01 //Magic Eidolon
        const val VT_VTOY_SMV01A: Byte = 0x02 //Smart Mini Vibe Plus
        const val VT_VTOY_SMV16: Byte = 0x06 //Magic Vini
        const val VT_VTOY_SMV05: Byte = 0x08 //Magic Flamingo
        const val VT_VTOY_ODV03: Byte = 0x0D //Solstice，墨月
        const val VT_VTOY_ODV11: Byte = 0x13 //Awaken，幻唇
        const val VT_VTOY_ODV14: Byte = 0x16 //Equinox，黑客
        const val VT_VTOY_SMV15: Byte = 0x17 //Magic Fugu，泡泡鱼
        const val VT_VTOY_SMV18: Byte = 0x18 //Magic lotos，莲悦
        const val VT_VTOY_SMV23: Byte = 0x19 //Magic Sundea，圣代
        const val VT_VTOY_SMV26: Byte = 0x1C //Magic Bobi，啵啵龙
        const val VT_VTOY_SMV27: Byte = 0x1D //Magic Nyx
        const val VT_VTOY_SMV28: Byte = 0x1E //Magic Umi，Umi 悠米
        const val VT_VTOY_SMV07X: Byte = 0x1F //SMV07X 粒子
        const val VT_VTOY_SMV05T: Byte = 0x20 //Magic FlamingoT
        const val VT_VTOY_SMV15T: Byte = 0x21 //Fugu2
        const val VT_VTOY_SMV27B: Byte = 0x22 //Magic Nyx
        const val VT_VTOY_FUN01: Byte = 0x23 //funone
        const val VT_VTOY_FUN07: Byte = 0x24 //fun07  Magic Bobi，啵啵龙
        const val VT_VTOY_SMV32: Byte = 0x26
        const val VT_VTOY_SMV33: Byte = 0x27
        const val VT_VTOY_SMV08: Byte = 0x04 //Magic Bayman
        const val VT_VTOY_ODV01: Byte = 0x0B //Smart Dildo
        const val VT_VTOY_ODV02: Byte = 0x0C //Buddy
        const val VT_VTOY_ODV05: Byte = 0x0E //Ball Lover
        const val VT_VTOY_ODV06: Byte = 0x0F //Double Lover
        const val VT_VTOY_ODV07: Byte = 0x10 //Classic(双马达)
        const val VT_VTOY_ODV08: Byte = 0x11 //Slim(双马达)
        const val VT_VTOY_CBT05: Byte = 0x2D //cbt05

        var DEVICE_NAMES = hashMapOf(
            VT_VTOY_SMV07 to INVALID_NAME, //粒子，Magic Dante，Magic Candy
            VT_VTOY_SMV06 to "Magic Eidolon", //精灵，Magic Eidolon
            VT_VTOY_SMV01A to "Smart Mini Vibe Plus", //魅动小V二代，smart mini vibe plus
            VT_VTOY_SMV08 to "Magic Wand", //暖男，Bayman
            VT_VTOY_SMV16 to "Magic Vini", //小V三代，Magic Vini
            VT_VTOY_SMV05 to "Magic Flamingo", //火烈鸟，Magic Flamingo
            VT_VTOY_SMV05T to "Magic Flamingo", //火烈鸟，Magic FlamingoT
            VT_VTOY_ODV03 to "Solstice", //Solstice，墨月
            VT_VTOY_ODV11 to "Awaken", //Awaken，幻唇
            VT_VTOY_ODV14 to "Equinox", //Equinox，黑客
            VT_VTOY_SMV15 to "Magic Fugu", //泡泡鱼，Magic Fugu
            VT_VTOY_SMV15T to "Magic Fugu", //泡泡鱼，Magic Fugu
            VT_VTOY_SMV18 to "Magic lotos", //莲悦， Magic lotos
            VT_VTOY_SMV23 to "Magic Sundae", //圣代， Magic Sundea
            VT_VTOY_SMV26 to "Magic Bobi",//Magic Bobi，啵啵龙
            VT_VTOY_FUN07 to "Magic Bobi", //Magic Bobi，啵啵龙
            VT_VTOY_SMV27 to "Magic Nyx", //Magic Nyx
            VT_VTOY_SMV27B to "Magic Nyx", //Magic Nyx
            VT_VTOY_SMV28 to "Magic Umi", //悠米，Magic Umi
            VT_VTOY_SMV07X to INVALID_NAME,//粒子，Magic Dante，Magic Candy
            VT_VTOY_FUN01 to "Fun One", //fun01
            VT_VTOY_SMV32 to "Zenith",
            VT_VTOY_SMV33 to "Zenith Lite",
            VT_VTOY_ODV01 to INVALID_NAME,//Smart Dildo
            VT_VTOY_ODV02 to INVALID_NAME,//Buddy
            VT_VTOY_ODV05 to INVALID_NAME,//Ball Lover
            VT_VTOY_ODV06 to INVALID_NAME,//Double Lover
            VT_VTOY_ODV07 to INVALID_NAME,//Classic
            VT_VTOY_ODV08 to INVALID_NAME, //Slim
            VT_VTOY_CBT05 to "CBT05", //Slim
        )

    }
}