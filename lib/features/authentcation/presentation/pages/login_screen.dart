import 'package:flutter/material.dart';

import '../widgets/auth_colors.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_logo.dart';
import '../widgets/background_image.dart';
import '../widgets/email_text_field.dart';
import '../widgets/forgot_password.dart';
import '../widgets/login_button.dart';
import '../widgets/login_header.dart';
import '../widgets/password_text_field.dart';
import '../widgets/sign_up_text.dart';
import '../widgets/social_login.dart';
import 'package:go_router/go_router.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);


  }

  void _handleForgotPassword() {
   
  }

  void _handleGoogleLogin() {
    
  }

  void _handleAppleLogin() {
    
  }

  void _handleSignUp() {
    context.go('/signup');
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email or phone';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 3),
                      const AuthLogo(),
                      const SizedBox(height: 8),
                      const LoginHeader(),
                      const Spacer(flex: 3),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            EmailTextField(
                              controller: _emailController,
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              controller: _passwordController,
                              validator: _validatePassword,
                            ),
                            const SizedBox(height: 8),
                            ForgotPassword(onTap: _handleForgotPassword),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LoginButton(
                        onPressed: _handleLogin,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 28),
                      const AuthDivider(),
                      const SizedBox(height: 20),
                      SocialLogin(
                        onGooglePressed: _handleGoogleLogin,
                        onApplePressed: _handleAppleLogin,
                      ),
                      const Spacer(flex: 2),
                      SignUpText(onSignUpTap: _handleSignUp),
                      const SizedBox(height: 16),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
