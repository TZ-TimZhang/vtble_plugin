import 'package:flutter_test/flutter_test.dart';
import 'package:vtble_plugin/src/model/ble_status.dart';
import 'package:vtble_plugin/src/model/device_event.dart';
import 'package:vtble_plugin/src/model/scan_config.dart';
import 'package:vtble_plugin/src/vtble_plugin.dart';
import 'package:vtble_plugin/src/vtble_plugin_platform_interface.dart';
import 'package:vtble_plugin/src/vtble_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVtblePluginPlatform with MockPlatformInterfaceMixin implements VtblePluginPlatform {
  @override
  Future<bool> applyPermission() {
    return Future.value(true);
  }

  @override
  Stream<BleStatus> get bleStatusStream => throw UnimplementedError();

  @override
  Future<BleStatus> checkBleState() {
    // TODO: implement checkBleState
    throw UnimplementedError();
  }

  @override
  Future<void> connect(String uuid) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  // TODO: implement connectStream
  Stream<ConnectEvent> get connectStream => throw UnimplementedError();

  @override
  Future<bool> isConnected() {
    // TODO: implement isConnected
    throw UnimplementedError();
  }

  @override
  Future<bool> isScanning() {
    // TODO: implement isScanning
    throw UnimplementedError();
  }

  @override
  Future<void> moveToBack() {
    // TODO: implement moveToBack
    throw UnimplementedError();
  }

  @override
  Future<bool> openBluetoothService() {
    // TODO: implement openBluetoothService
    throw UnimplementedError();
  }

  @override
  Future<bool> openLocationService() {
    // TODO: implement openLocationService
    throw UnimplementedError();
  }

  @override
  // TODO: implement scanStream
  Stream<ScanEvent> get scanStream => throw UnimplementedError();

  @override
  Future<void> setCommandInterval(int interval) {
    // TODO: implement setCommandInterval
    throw UnimplementedError();
  }

  @override
  Future<void> setKey(String key) {
    // TODO: implement setKey
    throw UnimplementedError();
  }

  @override
  Future<void> setLogEnable(bool isEnable) {
    // TODO: implement setLogEnable
    throw UnimplementedError();
  }

  @override
  Future<void> startScan(ScanConfig config) {
    // TODO: implement startScan
    throw UnimplementedError();
  }

  @override
  // TODO: implement statusStream
  Stream<SdkEvent> get statusStream => throw UnimplementedError();

  @override
  Future<void> stopScan() {
    // TODO: implement stopScan
    throw UnimplementedError();
  }

  @override
  void stopVibrate() {
    // TODO: implement stopVibrate
  }

  @override
  void writeCloseLed() {
    // TODO: implement writeCloseLed
  }

  @override
  void writeDualMotorDualLED(int motor1, int motor2, int led1, int led2) {
    // TODO: implement writeDualMotorDualLED
  }

  @override
  void writeDualMotorLED(int motor1, int motor2, int led) {
    // TODO: implement writeDualMotorLED
  }

  @override
  void writeLed(int led) {
    // TODO: implement writeLed
  }

  @override
  void writeMotor(int value) {
    // TODO: implement writeMotor
  }

  @override
  void writeMotorLED(int motor, int led) {
    // TODO: implement writeMotorLED
  }
}

void main() {
  final VtblePluginPlatform initialPlatform = VtblePluginPlatform.instance;

  test('$MethodChannelVtblePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVtblePlugin>());
  });

  test('getPlatformVersion', () async {
    VtblePlugin vtblePlugin = VtblePlugin.instance;
    MockVtblePluginPlatform fakePlatform = MockVtblePluginPlatform();
    VtblePluginPlatform.instance = fakePlatform;

    expect(await vtblePlugin.applyPermission(), true);
  });
}
