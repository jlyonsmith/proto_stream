// This is a generated file - do not edit.
//
// Generated from schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use headerDescriptor instead')
const Header$json = {
  '1': 'Header',
  '2': [
    {
      '1': 'error',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.msg_schema.Error',
      '9': 0,
      '10': 'error'
    },
    {
      '1': 'info',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.msg_schema.Info',
      '9': 0,
      '10': 'info'
    },
  ],
  '8': [
    {'1': 'msg'},
  ],
};

/// Descriptor for `Header`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List headerDescriptor = $convert.base64Decode(
    'CgZIZWFkZXISKQoFZXJyb3IYASABKAsyES5tc2dfc2NoZW1hLkVycm9ySABSBWVycm9yEiYKBG'
    'luZm8YAiABKAsyEC5tc2dfc2NoZW1hLkluZm9IAFIEaW5mb0IFCgNtc2c=');

@$core.Deprecated('Use errorDescriptor instead')
const Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'error_no', '3': 1, '4': 1, '5': 5, '10': 'errorNo'},
    {'1': 'error_msg', '3': 2, '4': 1, '5': 9, '10': 'errorMsg'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode(
    'CgVFcnJvchIZCghlcnJvcl9ubxgBIAEoBVIHZXJyb3JObxIbCgllcnJvcl9tc2cYAiABKAlSCG'
    'Vycm9yTXNn');

@$core.Deprecated('Use infoDescriptor instead')
const Info$json = {
  '1': 'Info',
  '2': [
    {'1': 'protocol_ver', '3': 1, '4': 1, '5': 5, '10': 'protocolVer'},
  ],
};

/// Descriptor for `Info`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List infoDescriptor = $convert
    .base64Decode('CgRJbmZvEiEKDHByb3RvY29sX3ZlchgBIAEoBVILcHJvdG9jb2xWZXI=');
