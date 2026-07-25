import 'package:flutter/material.dart';
import '../utils/validators.dart';
import 'auth_text_field.dart';

/// The signup form fields (full name, email, phone, password, confirm
/// password), wrapped in a [Form] so the page can validate everything
/// with a single [formKey].
class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            controller: fullNameController,
            hintText: 'Full Name',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: Validators.fullName,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: emailController,
            hintText: 'Email Address',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: Validators.phone,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: passwordController,
            hintText: 'Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            validator: Validators.password,
          ),
          const SizedBox(height: 14),
          AuthTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (value) =>
                Validators.confirmPassword(passwordController.text)(value),
          ),
        ],
      ),
    );
  }
}
