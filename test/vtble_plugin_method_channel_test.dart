import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vtble_plugin/src/vtble_plugin_method_channel.dart';
import 'package:vtble_plugin/vtble_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelVtblePlugin platform = MethodChannelVtblePluginFactory.create();
  const MethodChannel channel = MethodChannel('vtble_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.checkBleState(), BleStatus.unknown);
  });
}
