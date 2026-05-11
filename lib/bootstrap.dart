import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'core/remote_config/remote_config_service.dart';
import 'flavors.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 1. Init Firebase (phải trước DI vì FirebaseModule dùng Firebase.app())
  await Firebase.initializeApp();

  // 2. Setup DI
  await configureDependencies(F.name);

  // 3. Fetch Remote Config (non-blocking — app vẫn chạy nếu lỗi)
  await getIt<RemoteConfigService>().init();

  runApp(const App());
}
