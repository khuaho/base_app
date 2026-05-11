import 'package:base_app/core/error/exceptions.dart';
import 'package:base_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:base_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:base_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'auth_state.dart';

export 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthState());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  Future<void> checkAuth() async {
    emit(const AuthState(isLoading: true));
    try {
      final user = await _getCurrentUserUseCase();
      emit(user != null
          ? AuthState(user: user)
          : const AuthState(isUnauthenticated: true));
    } catch (_) {
      emit(const AuthState(isUnauthenticated: true));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState(isLoading: true));
    try {
      final user = await _loginUseCase(
        LoginParams(email: email, password: password),
      );
      emit(AuthState(user: user));
    } on UnauthorizedException {
      emit(const AuthState(error: 'Invalid credentials'));
    } on NetworkException {
      emit(const AuthState(error: 'No internet connection'));
    } catch (_) {
      emit(const AuthState(error: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    emit(const AuthState(isUnauthenticated: true));
  }
}
