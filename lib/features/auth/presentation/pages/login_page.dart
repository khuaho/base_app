import 'package:auto_route/auto_route.dart';
import 'package:base_app/core/utils/context_extensions.dart';
import 'package:base_app/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                context.l10n.loginTitle,
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.loginSubtitle,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
