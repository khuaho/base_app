import 'package:base_app/features/auth/domain/entities/user_entity.dart';
import 'package:base_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:base_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:base_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:base_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

const _tUser = UserEntity(id: '1', email: 'test@test.com', name: 'Test User');

void main() {
  late MockLoginUseCase mockLogin;
  late MockLogoutUseCase mockLogout;
  late MockGetCurrentUserUseCase mockGetCurrentUser;

  setUp(() {
    mockLogin = MockLoginUseCase();
    mockLogout = MockLogoutUseCase();
    mockGetCurrentUser = MockGetCurrentUserUseCase();
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  AuthCubit buildCubit() => AuthCubit(mockLogin, mockLogout, mockGetCurrentUser);

  group('checkAuth', () {
    test('emits loading rồi authenticated khi có user', () async {
      when(() => mockGetCurrentUser()).thenAnswer((_) async => _tUser);
      final cubit = buildCubit();
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.checkAuth();

      expect(states, [
        const AuthState(isLoading: true),
        const AuthState(user: _tUser),
      ]);
    });

    test('emits loading rồi unauthenticated khi không có user', () async {
      when(() => mockGetCurrentUser()).thenAnswer((_) async => null);
      final cubit = buildCubit();
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.checkAuth();

      expect(states, [
        const AuthState(isLoading: true),
        const AuthState(isUnauthenticated: true),
      ]);
    });
  });

  group('login', () {
    test('emits loading rồi user khi thành công', () async {
      when(() => mockLogin(any())).thenAnswer((_) async => _tUser);
      final cubit = buildCubit();
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.login(email: 'test@test.com', password: 'password');

      expect(states, [
        const AuthState(isLoading: true),
        const AuthState(user: _tUser),
      ]);
    });

    test('emits loading rồi error khi thất bại', () async {
      when(() => mockLogin(any())).thenThrow(Exception());
      final cubit = buildCubit();
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.login(email: 'test@test.com', password: 'wrong');

      expect(states, [
        const AuthState(isLoading: true),
        const AuthState(error: 'Something went wrong. Please try again.'),
      ]);
    });
  });

  group('logout', () {
    test('emits unauthenticated sau khi logout', () async {
      when(() => mockLogout()).thenAnswer((_) async {});
      final cubit = buildCubit();
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.logout();

      expect(states, [const AuthState(isUnauthenticated: true)]);
    });
  });
}
