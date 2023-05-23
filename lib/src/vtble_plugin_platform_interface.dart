import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'model/ble_status.dart';
import 'model/device_event.dart';
import 'model/scan_config.dart';
import 'vtble_plugin_method_channel.dart';

abstract class VtblePluginPlatform extends PlatformInterface {
  /// Constructs a VtblePluginPlatform.
  VtblePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static VtblePluginPlatform _instance = MethodChannelVtblePluginFactory.create();

  /// The default instance of [VtblePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelVtblePlugin].
  static VtblePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VtblePluginPlatform] when
  /// they register themselves.
  static set instance(VtblePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Stream providing ble scan results.
  ///
  /// It is important to subscribe to this stream before scanning for devices
  /// since it can happen that some results are missed.
  Stream<ScanEvent> get scanStream {
    throw UnimplementedError('scanStream has not been implemented.');
  }

  Stream<ConnectEvent> get connectStream {
    throw UnimplementedError('connectStream has not been implemented.');
  }

  Stream<SdkEvent> get statusStream {
    throw UnimplementedError('statusStream has not been implemented.');
  }

  Stream<BleStatus> get bleStatusStream {
    throw UnimplementedError('bleStatusStream has not been implemented.');
  }

  Future<void> moveToBack() {
    throw UnimplementedError('moveToBack() has not been implemented.');
  }

  Future<BleStatus> checkBleState() {
    throw UnimplementedError('checkBleState() has not been implemented.');
  }

  Future<bool> applyPermission() {
    throw UnimplementedError('applyPermission() has not been implemented.');
  }

  Future<void> setLogEnable(bool isEnable) {
    throw UnimplementedError('setLogEnable() has not been implemented.');
  }

  Future<void> setKey(String key) {
    throw UnimplementedError('setKey() has not been implemented.');
  }

  Future<bool> openBluetoothService() {
    throw UnimplementedError('openBluetoothService() has not been implemented.');
  }

  Future<bool> openLocationService() {
    throw UnimplementedError('openLocationService() has not been implemented.');
  }

  Future<void> startScan(ScanConfig config) {
    throw UnimplementedError('startScan() has not been implemented.');
  }

  Future<void> stopScan() {
    throw UnimplementedError('stopScan() has not been implemented.');
  }

  Future<bool> isScanning() {
    throw UnimplementedError('isScanning() has not been implemented.');
  }

  Future<void> connect(String uuid) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  Future<bool> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  void writeMotor(int value) {
    throw UnimplementedError('writeMotor() has not been implemented.');
  }

  void stopVibrate() {
    throw UnimplementedError('stopVibrate() has not been implemented.');
  }

  void writeMotorLED(int motor, int led) {
    throw UnimplementedError('writeMotorLED() has not been implemented.');
  }

  void writeDualMotorLED(int motor1, int motor2, int led) {
    throw UnimplementedError('writeDualMotorLED() has not been implemented.');
  }

  void writeDualMotorDualLED(int motor1, int motor2, int led1, int led2) {
    throw UnimplementedError('writeDualMotorDualLED() has not been implemented.');
  }

  void writeLed(int led) {
    throw UnimplementedError('writeLed() has not been implemented.');
  }

  void writeCloseLed() {
    throw UnimplementedError('writeCloseLed() has not been implemented.');
  }

  Future<void> setCommandInterval(int interval) {
    throw UnimplementedError('setCommandInterval() has not been implemented.');
  }
}
