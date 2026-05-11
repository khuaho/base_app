import 'package:base_app/core/remote_config/remote_config_defaults.dart';
import 'package:base_app/core/remote_config/remote_config_keys.dart';
import 'package:base_app/flavors.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoteConfigService {
  RemoteConfigService(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  // ── Init ──────────────────────────────────────────────────────────────────
  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        // Dev: fetch mỗi lần để test nhanh
        // Prod: cache 1 tiếng
        fetchTimeout: const Duration(seconds: 15),
        minimumFetchInterval: F.appFlavor == Flavor.dev
            ? Duration.zero
            : const Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults(remoteConfigDefaults);

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // Không crash app nếu fetch lỗi — dùng defaults hoặc cached values
      debugPrint('[RemoteConfig] fetchAndActivate failed: $e');
    }
  }

  // ── Getters ───────────────────────────────────────────────────────────────
  String getString(String key) => _remoteConfig.getString(key);
  bool   getBool(String key)   => _remoteConfig.getBool(key);
  int    getInt(String key)    => _remoteConfig.getInt(key);
  double getDouble(String key) => _remoteConfig.getDouble(key);

  // ── Shorthand cho các key thường dùng ─────────────────────────────────────
  bool   get forceUpdate        => getBool(RemoteConfigKeys.forceUpdate);
  String get minAppVersion      => getString(RemoteConfigKeys.minAppVersion);
  bool   get maintenanceMode    => getBool(RemoteConfigKeys.maintenanceMode);
  String get maintenanceMessage => getString(RemoteConfigKeys.maintenanceMessage);

  // ── Realtime listener (optional) ──────────────────────────────────────────
  /// Lắng nghe thay đổi realtime từ Firebase Console (không cần restart app).
  void listenToUpdates(void Function() onUpdate) {
    _remoteConfig.onConfigUpdated.listen((_) async {
      await _remoteConfig.activate();
      onUpdate();
    });
  }
}
