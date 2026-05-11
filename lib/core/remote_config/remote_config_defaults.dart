import 'package:base_app/core/remote_config/remote_config_keys.dart';

/// Default values dùng khi chưa fetch được Remote Config
/// hoặc key chưa tồn tại trên Firebase Console.
const Map<String, dynamic> remoteConfigDefaults = {
  RemoteConfigKeys.forceUpdate:        false,
  RemoteConfigKeys.minAppVersion:      '1.0.0',
  RemoteConfigKeys.maintenanceMode:    false,
  RemoteConfigKeys.maintenanceMessage: 'We are under maintenance. Please try again later.',
};
