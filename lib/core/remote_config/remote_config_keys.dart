/// Tất cả Remote Config keys tập trung ở đây.
/// Tên key phải khớp chính xác với key đã tạo trên Firebase Console.
abstract class RemoteConfigKeys {
  RemoteConfigKeys._();

  static const String forceUpdate        = 'force_update';
  static const String minAppVersion      = 'min_app_version';
  static const String maintenanceMode    = 'maintenance_mode';
  static const String maintenanceMessage = 'maintenance_message';
}
