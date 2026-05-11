import 'package:auto_route/auto_route.dart';
import 'package:base_app/features/auth/presentation/pages/login_page.dart';
import 'package:base_app/features/auth/presentation/pages/splash_page.dart';
import 'package:base_app/features/home/presentation/pages/home_page.dart';
import 'package:injectable/injectable.dart';

import 'guards/auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@singleton
class AppRouter extends RootStackRouter {
  AppRouter(this._authGuard);

  final AuthGuard _authGuard;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          guards: [_authGuard],
        ),
      ];
}
