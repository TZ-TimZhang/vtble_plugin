///
//  Generated code. Do not modify.
//  source: plugindata.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use bleStatusInfoDescriptor instead')
const BleStatusInfo$json = const {
  '1': 'BleStatusInfo',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
  ],
};

/// Descriptor for `BleStatusInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bleStatusInfoDescriptor = $convert.base64Decode('Cg1CbGVTdGF0dXNJbmZvEhYKBnN0YXR1cxgBIAEoBVIGc3RhdHVz');
@$core.Deprecated('Use scanDeviceTypeDescriptor instead')
const ScanDeviceType$json = const {
  '1': 'ScanDeviceType',
  '2': const [
    const {'1': 'protocol', '3': 1, '4': 1, '5': 5, '10': 'protocol'},
    const {'1': 'device_type', '3': 2, '4': 1, '5': 5, '10': 'deviceType'},
    const {'1': 'sub_type', '3': 3, '4': 1, '5': 5, '10': 'subType'},
    const {'1': 'vendor', '3': 4, '4': 1, '5': 5, '10': 'vendor'},
  ],
};

/// Descriptor for `ScanDeviceType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanDeviceTypeDescriptor = $convert.base64Decode('Cg5TY2FuRGV2aWNlVHlwZRIaCghwcm90b2NvbBgBIAEoBVIIcHJvdG9jb2wSHwoLZGV2aWNlX3R5cGUYAiABKAVSCmRldmljZVR5cGUSGQoIc3ViX3R5cGUYAyABKAVSB3N1YlR5cGUSFgoGdmVuZG9yGAQgASgFUgZ2ZW5kb3I=');
@$core.Deprecated('Use scanConfigRequestDescriptor instead')
const ScanConfigRequest$json = const {
  '1': 'ScanConfigRequest',
  '2': const [
    const {'1': 'mac', '3': 1, '4': 1, '5': 9, '10': 'mac'},
    const {'1': 'scan_only', '3': 2, '4': 1, '5': 8, '10': 'scanOnly'},
  ],
};

/// Descriptor for `ScanConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanConfigRequestDescriptor = $convert.base64Decode('ChFTY2FuQ29uZmlnUmVxdWVzdBIQCgNtYWMYASABKAlSA21hYxIbCglzY2FuX29ubHkYAiABKAhSCHNjYW5Pbmx5');
@$core.Deprecated('Use scanForDevicesRequestDescriptor instead')
const ScanForDevicesRequest$json = const {
  '1': 'ScanForDevicesRequest',
  '2': const [
    const {'1': 'scan_device_types', '3': 1, '4': 3, '5': 11, '6': '.ScanDeviceType', '10': 'scanDeviceTypes'},
    const {'1': 'timeout_in_seconds', '3': 2, '4': 1, '5': 5, '10': 'timeoutInSeconds'},
    const {'1': 'scan_config', '3': 3, '4': 1, '5': 11, '6': '.ScanConfigRequest', '10': 'scanConfig'},
  ],
};

/// Descriptor for `ScanForDevicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanForDevicesRequestDescriptor = $convert.base64Decode('ChVTY2FuRm9yRGV2aWNlc1JlcXVlc3QSOwoRc2Nhbl9kZXZpY2VfdHlwZXMYASADKAsyDy5TY2FuRGV2aWNlVHlwZVIPc2NhbkRldmljZVR5cGVzEiwKEnRpbWVvdXRfaW5fc2Vjb25kcxgCIAEoBVIQdGltZW91dEluU2Vjb25kcxIzCgtzY2FuX2NvbmZpZxgDIAEoCzISLlNjYW5Db25maWdSZXF1ZXN0UgpzY2FuQ29uZmln');
@$core.Deprecated('Use connectRequestDescriptor instead')
const ConnectRequest$json = const {
  '1': 'ConnectRequest',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
  ],
};

/// Descriptor for `ConnectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectRequestDescriptor = $convert.base64Decode('Cg5Db25uZWN0UmVxdWVzdBISCgR1dWlkGAEgASgJUgR1dWlk');
@$core.Deprecated('Use motorDataRequestDescriptor instead')
const MotorDataRequest$json = const {
  '1': 'MotorDataRequest',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
  ],
};

/// Descriptor for `MotorDataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List motorDataRequestDescriptor = $convert.base64Decode('ChBNb3RvckRhdGFSZXF1ZXN0EhQKBXZhbHVlGAEgASgFUgV2YWx1ZQ==');
@$core.Deprecated('Use deviceInfoDescriptor instead')
const DeviceInfo$json = const {
  '1': 'DeviceInfo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'firm_ware_version', '3': 2, '4': 1, '5': 9, '10': 'firmWareVersion'},
    const {'1': 'uuid', '3': 3, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'is_dual_motor', '3': 4, '4': 1, '5': 8, '10': 'isDualMotor'},
    const {'1': 'is_dual_led', '3': 5, '4': 1, '5': 8, '10': 'isDualLed'},
    const {'1': 'identifier', '3': 6, '4': 1, '5': 11, '6': '.ScanDeviceType', '10': 'identifier'},
  ],
};

/// Descriptor for `DeviceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInfoDescriptor = $convert.base64Decode('CgpEZXZpY2VJbmZvEhIKBG5hbWUYASABKAlSBG5hbWUSKgoRZmlybV93YXJlX3ZlcnNpb24YAiABKAlSD2Zpcm1XYXJlVmVyc2lvbhISCgR1dWlkGAMgASgJUgR1dWlkEiIKDWlzX2R1YWxfbW90b3IYBCABKAhSC2lzRHVhbE1vdG9yEh4KC2lzX2R1YWxfbGVkGAUgASgIUglpc0R1YWxMZWQSLwoKaWRlbnRpZmllchgGIAEoCzIPLlNjYW5EZXZpY2VUeXBlUgppZGVudGlmaWVy');
@$core.Deprecated('Use deviceEventDescriptor instead')
const DeviceEvent$json = const {
  '1': 'DeviceEvent',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'device_info', '3': 2, '4': 1, '5': 11, '6': '.DeviceInfo', '10': 'deviceInfo'},
  ],
};

/// Descriptor for `DeviceEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceEventDescriptor = $convert.base64Decode('CgtEZXZpY2VFdmVudBISCgR0eXBlGAEgASgJUgR0eXBlEiwKC2RldmljZV9pbmZvGAIgASgLMgsuRGV2aWNlSW5mb1IKZGV2aWNlSW5mbw==');
