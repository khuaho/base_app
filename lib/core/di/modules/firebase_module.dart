import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  /// Firebase đã được init trong bootstrap.dart trước khi DI chạy.
  @lazySingleton
  FirebaseApp get firebaseApp => Firebase.app();

  @lazySingleton
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;
}
