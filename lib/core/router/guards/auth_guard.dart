import 'package:auto_route/auto_route.dart';
import 'package:base_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../app_router.dart';

@injectable
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      resolver.next(true);
    } else {
      router.replace(const LoginRoute());
    }
  }
}
