import 'package:auto_route/auto_route.dart';
import 'package:base_app/core/utils/context_extensions.dart';
import 'package:base_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isUnauthenticated) {
          context.router.replace(const LoginRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.homeTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: context.l10n.logoutButton,
              onPressed: () => context.read<AuthCubit>().logout(),
            ),
          ],
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => Center(
            child: Text(
              'Hello, ${state.user?.name ?? ''} 👋',
              style: context.textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
