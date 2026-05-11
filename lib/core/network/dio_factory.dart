import 'package:base_app/core/constants/app_constants.dart';
import 'package:base_app/core/network/interceptors/auth_interceptor.dart';
import 'package:base_app/core/network/interceptors/log_interceptor.dart';
import 'package:base_app/core/storage/secure_storage.dart';
import 'package:base_app/flavors.dart';
import 'package:dio/dio.dart';

class DioFactory {
  DioFactory._();

  static Dio create(SecureStorage secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: F.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (F.enableLogging) {
      dio.interceptors.add(AppLogInterceptor());
    }
    dio.interceptors.add(AuthInterceptor(secureStorage));

    return dio;
  }
}
