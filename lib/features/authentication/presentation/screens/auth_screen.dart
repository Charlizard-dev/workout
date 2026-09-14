import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/buttons.dart';
import '../bloc/auth_bloc.dart';

/// Sign-in / create-account screen. Local-first: credentials never leave
/// the device in v1.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _registerMode = false;
  bool _obscurePassword = true;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    HapticFeedback.lightImpact();
    final bloc = context.read<AuthBloc>();
    if (_registerMode) {
      bloc.add(AuthRegisterSubmitted(
        name: _name.text,
        email: _email.text,
        password: _password.text,
      ));
    } else {
      bloc.add(AuthLoginSubmitted(
        email: _email.text,
        password: _password.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          } else if (state is AuthUnauthenticated &&
              state.message != null) {
            HapticFeedback.heavyImpact();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          final submitting = state is AuthSubmitting;
          final checking =
              state is AuthChecking && !_registerMode && _email.text.isEmpty;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/charlizard_logo.svg',
                            width: 96,
                            height: 96,
                            semanticsLabel: 'Charlizard logo',
                            placeholderBuilder: (_) => const Icon(
                              Icons.fitness_center_rounded,
                              size: 64,
                              color: AppPalette.ember,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          _registerMode
                              ? 'CREATE YOUR ACCOUNT'
                              : 'WELCOME BACK',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          _registerMode
                              ? 'Your training data stays on this device.'
                              : 'Pick up right where you left off.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppPalette.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        if (_registerMode) ...[
                          _AuthField(
                            controller: _name,
                            label: 'Display name',
                            hint: 'e.g. Charly',
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            validator: (v) =>
                                (v == null || v.trim().length < 2)
                                    ? 'Enter your name'
                                    : null,
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        _AuthField(
                          controller: _email,
                          label: 'Email',
                          hint: 'you@example.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null ||
                                  !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                      .hasMatch(v.trim()))
                              ? 'Enter a valid email'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _AuthField(
                          controller: _password,
                          label: 'Password',
                          hint: _registerMode
                              ? '8 or more characters'
                              : 'Your password',
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submit(),
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                              color: AppPalette.textTertiary,
                            ),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                          ),
                          validator: (v) => (v == null || v.length < 8)
                              ? 'Use at least 8 characters'
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        if (checking)
                          const Center(
                              child: CircularProgressIndicator(
                                  color: AppPalette.ember))
                        else
                          PrimaryButton(
                            label: submitting
                                ? 'PLEASE WAIT…'
                                : _registerMode
                                    ? 'CREATE ACCOUNT'
                                    : 'LOG IN',
                            onPressed: submitting ? null : _submit,
                          ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _registerMode
                                  ? 'Already have an account?'
                                  : 'New to Charlizard?',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppPalette.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: submitting
                                  ? null
                                  : () => setState(
                                      () => _registerMode = !_registerMode),
                              child: Text(
                                _registerMode ? 'Log in' : 'Create one',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppPalette.ember,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.suffix,
    this.validator,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            color: AppPalette.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
