import 'package:flutter/material.dart';

import '../signup_widgets/signup_header.dart';
import '../signup_widgets/signup_form.dart';
import '../signup_widgets/signup_button.dart';
import '../widgets/auth_colors.dart';
import '../signup_widgets/auth_footer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/authentcation_cubit.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 Future<void> _handleSignUp() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  try {
    await context.read<AuthCubit>().register(
      name: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phonenumber: _phoneController.text.trim(),
    );

    if (!mounted) return;

    context.push(
      '/otp',
      extra: _emailController.text.trim(),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

  void _handleGoogleSignUp() {
    // TODO: trigger Google sign-in flow.
  }

  void _handleAppleSignUp() {
    // TODO: trigger Apple sign-in flow.
  }

  void _handleLoginTap() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SignupHeader(),
              const SizedBox(height: 20),
              SignupForm(
                formKey: _formKey,
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 20),
              SignupButton(
                onPressed: _handleSignUp,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 24),
              AuthFooter(
                dividerLabel: 'OR SIGN UP WITH',
                onGooglePressed: _handleGoogleSignUp,
                onApplePressed: _handleAppleSignUp,
                promptText: 'Already have an account? ',
                actionText: 'Login',
                onActionTap: _handleLoginTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
