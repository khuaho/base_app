import 'package:base_app/core/constants/app_constants.dart';
import 'package:base_app/core/error/exceptions.dart';
import 'package:base_app/core/storage/secure_storage.dart';
import 'package:base_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:base_app/features/auth/data/models/user_model.dart';
import 'package:base_app/features/auth/domain/entities/user_entity.dart';
import 'package:base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorage _secureStorage;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login({
        'email': email,
        'password': password,
      });
      await _secureStorage.write(
          key: AppConstants.accessTokenKey, value: response.accessToken);
      await _secureStorage.write(
          key: AppConstants.refreshTokenKey, value: response.refreshToken);
      return response.user.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw const UnauthorizedException();
      throw ServerException(
        message: e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // best-effort
    } finally {
      await _secureStorage.deleteAll();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: AppConstants.accessTokenKey);
    return token != null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getMe();
      return user.toEntity();
    } catch (_) {
      return null;
    }
  }
}
