import 'package:base_app/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    UserEntity? user,
    String? error,
    @Default(false) bool isUnauthenticated,
  }) = _AuthState;
}
