import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vtble_plugin/vtble_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BleStatus _bleStatus = BleStatus.unknown;

  StreamSubscription<BleStatus>? _stateSubscription;

  final List<ScanType> _scanTypes = [];

  final List<DeviceInfo> _scanDevice = [];

  final _blePlugin = VtblePlugin.instance;

  String _connectStatus = '';
  String _statusStream = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _stateSubscription = _blePlugin.bleStatusStream.listen((event) {
      debugPrint('蓝牙状态改变 ${event.name}');
      final bleState = event;
      setState(() {
        _bleStatus = bleState;
      });
    });

    // var bleState = await _blePlugin.checkBleState();
    _blePlugin.scanStream.listen((event) {
      switch (event.type) {
        case ScanEventType.start:
          _scanDevice.clear();
          break;
        case ScanEventType.stop:
        case ScanEventType.timeout:
          return;
        case ScanEventType.discovered:
          if (event.deviceInfo != null) {
            _scanDevice.add(event.deviceInfo!);
          }
          break;
        case ScanEventType.unknown:
          break;
      }

      setState(() {});
    });
    _blePlugin.connectStream.listen((event) {
      debugPrint('connectStream $event');
      setState(() {
        _connectStatus = '$event';
      });
    });
    _blePlugin.statusStream.listen((event) {
      debugPrint('statusStream $event');
      setState(() {
        _statusStream = '$event';
      });
    });
    if (!mounted) return;

    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x00, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x01, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x02, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x04, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x06, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x08, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x0B, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x0C, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x0D, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x0E, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x0F, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x10, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x11, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x13, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x16, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x17, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x18, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x19, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x1C, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x1D, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x1E, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x1F, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x20, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x21, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x22, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x23, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x24, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x26, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x27, vendor: 0xFF));
    _scanTypes.add(ScanType(protocol: 0x01, deviceType: 0x02, subType: 0x2D, vendor: 0xFF));
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('蓝牙插件测试'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('蓝牙状态：${_bleStatus.name}'),
                Text('连接状态：$_connectStatus'),
                Text('SDK状态：$_statusStream'),
                if (_bleStatus == BleStatus.unsupported) const Text('手机不支持蓝牙'),
                if (_bleStatus == BleStatus.poweredOff)
                  MaterialButton(
                    onPressed: () async {
                      final result = await _blePlugin.openBluetoothService();
                      debugPrint('打开蓝牙 $result');
                    },
                    child: const Text('打开蓝牙'),
                  ),
                if (_bleStatus == BleStatus.locationServicesDisabled)
                  MaterialButton(
                    onPressed: () async {
                      final result = await _blePlugin.openLocationService();
                      debugPrint('打开定位 $result');
                    },
                    child: const Text('打开定位'),
                  ),
                if (_bleStatus == BleStatus.unauthorized)
                  MaterialButton(
                    onPressed: () async {
                      final result = await _blePlugin.applyPermission();
                      debugPrint('权限 $result');
                    },
                    child: const Text('请求蓝牙权限'),
                  ),
                if (_bleStatus == BleStatus.ready)
                  MaterialButton(
                    onPressed: () async {
                      await _blePlugin.startScan(ScanConfig(scanTypes: _scanTypes, timeoutInSecond: 200, scanDevice: ScanDevice(mac: "", scanOnly: true)));
                    },
                    child: const Text('开始扫描'),
                  ),
                MaterialButton(
                  onPressed: () async {
                    final value = (math.Random().nextDouble() * 100).toInt();
                    debugPrint('震动数据 $value');
                    _blePlugin.writeMotor(value);
                  },
                  child: const Text('测试震动'),
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    final item = _scanDevice[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      color: Colors.blueGrey,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(item.name ?? ''),
                                Text(item.uuid ?? ''),
                                Text(item.firmWareVersion ?? ''),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              if (item.uuid != null) {
                                await _blePlugin.connect(item.uuid!);
                              }
                            },
                            child: const Text('连接'),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: _scanDevice.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
