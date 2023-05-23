import 'model/ble_status.dart';
import 'model/device_event.dart';
import 'model/scan_config.dart';
import 'vtble_plugin_platform_interface.dart';

class VtblePlugin {
  static VtblePlugin instance = VtblePlugin._();

  VtblePlugin._();

  /// 扫描事件流
  /// {type: start}
  /// {type: stop}
  /// {type: timeOut}
  /// {type: discovered, deviceInfo: xxx}
  Stream<ScanEvent> get scanStream => VtblePluginPlatform.instance.scanStream;

  /// 连接状态流
  /// {type: connected, deviceInfo: xxx}
  /// {type: disconnected, deviceInfo: xxx}
  /// {type: serviceDiscovered, deviceInfo: xxx}
  Stream<ConnectEvent> get connectStream => VtblePluginPlatform.instance.connectStream;

  /// 蓝牙SDK状态流
  /// {type: init}
  /// {type: connected}
  /// {type: disconnected}
  Stream<SdkEvent> get statusStream => VtblePluginPlatform.instance.statusStream;

  /// 蓝牙状态流
  /// {unknown、unsupported、unauthorized、poweredOff、locationServicesDisabled、ready}
  Stream<BleStatus> get bleStatusStream => VtblePluginPlatform.instance.bleStatusStream;

  /// Android专属
  Future<void> moveToBack() {
    return VtblePluginPlatform.instance.moveToBack();
  }

  /// 设置日志开关
  Future<void> setLogEnable(bool isEnable) {
    return VtblePluginPlatform.instance.setLogEnable(isEnable);
  }

  /// 打开蓝牙服务(iOS无效)
  Future<bool> openBluetoothService() {
    return VtblePluginPlatform.instance.openBluetoothService();
  }

  /// 打开位置服务(iOS无效)
  Future<bool> openLocationService() {
    return VtblePluginPlatform.instance.openLocationService();
  }

  /// 开始扫描
  Future<void> startScan(ScanConfig config) {
    return VtblePluginPlatform.instance.startScan(config);
  }

  /// 停止扫描
  Future<void> stopScan() {
    return VtblePluginPlatform.instance.stopScan();
  }

  /// 是否扫描中
  Future<bool> isScanning() {
    return VtblePluginPlatform.instance.isScanning();
  }

  /// 连接
  Future<void> connect(String uuid) {
    return VtblePluginPlatform.instance.connect(uuid);
  }

  /// 是否已连接
  Future<bool> isConnected() {
    return VtblePluginPlatform.instance.isConnected();
  }

  /// 写入震动数据
  void writeMotor(int value) {
    return VtblePluginPlatform.instance.writeMotor(value);
  }

  /// 停止震动
  void stopVibrate() {
    return VtblePluginPlatform.instance.stopVibrate();
  }

  /// 写入震动数据及led
  void writeMotorLED(int motor, int led) {
    return VtblePluginPlatform.instance.writeMotorLED(motor, led);
  }

  /// 写入双马达振动数据及led
  void writeDualMotorLED(int motor1, int motor2, int led) {
    return VtblePluginPlatform.instance.writeDualMotorLED(motor1, motor2, led);
  }

  /// 写入双马达双灯震动数据
  void writeDualMotorDualLED(int motor1, int motor2, int led1, int led2) {
    return VtblePluginPlatform.instance.writeDualMotorDualLED(motor1, motor2, led1, led2);
  }

  /// 写入led
  void writeLed(int led) {
    return VtblePluginPlatform.instance.writeLed(led);
  }

  /// 关闭led
  void writeCloseLed() {
    return VtblePluginPlatform.instance.writeCloseLed();
  }

  /// 设置key
  Future<void> setKey(String key) {
    return VtblePluginPlatform.instance.setKey(key);
  }

  /// 请求权限
  Future<bool> applyPermission() {
    return VtblePluginPlatform.instance.applyPermission();
  }

  /// 检查蓝牙状态
  Future<BleStatus> checkBleState() {
    return VtblePluginPlatform.instance.checkBleState();
  }

  Future<void> setCommandInterval(int interval) {
    return VtblePluginPlatform.instance.setCommandInterval(interval);
  }
}
