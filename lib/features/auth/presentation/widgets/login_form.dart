import 'package:base_app/core/utils/context_extensions.dart';
import 'package:base_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:base_app/shared/extensions/string_extensions.dart';
import 'package:base_app/shared/widgets/app_button.dart';
import 'package:base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validate() {
    setState(() {
      _emailError = _emailController.text.trim().isValidEmail
          ? null
          : context.l10n.errorInvalidEmail;
      _passwordError = _passwordController.text.isEmpty
          ? context.l10n.errorEmptyPassword
          : null;
    });
    return _emailError == null && _passwordError == null;
  }

  void _submit() {
    if (!_validate()) return;
    context.read<AuthCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _emailController,
              label: context.l10n.emailLabel,
              errorText: _emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _passwordController,
              label: context.l10n.passwordLabel,
              errorText: _passwordError,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              enabled: !state.isLoading,
              onSubmitted: (_) => _submit(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            if (state.error != null) ...[
              const SizedBox(height: 12),
              Text(
                state.error!,
                style: context.textTheme.bodySmall
                    ?.copyWith(color: context.colors.error),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            AppButton(
              label: context.l10n.loginButton,
              onPressed: _submit,
              isLoading: state.isLoading,
            ),
          ],
        );
      },
    );
  }
}
