import 'package:base_app/core/network/dio_factory.dart';
import 'package:base_app/core/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(SecureStorage secureStorage) => DioFactory.create(secureStorage);
}
