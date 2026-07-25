// import 'package:flutter/material.dart';

// import '../widgets/auth_colors.dart';
// import '../widgets/auth_divider.dart';
// import '../widgets/auth_logo.dart';
// import '../widgets/email_text_field.dart';
// import '../widgets/login_button.dart';
// import '../widgets/login_header2.dart';
// import '../widgets/password_text_field.dart';
// import '../widgets/login_text.dart';
// import '../widgets/auth_back_button.dart';
// import '../widgets/full_name_text_field.dart';
// import '../widgets/phone_text_field.dart';
// import '../widgets/social_login.dart';
// import '../widgets/background_image.dart';
// import 'package:go_router/go_router.dart';





// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignUp() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     // TODO: Connect with Signup Cubit / UseCase
//     await Future.delayed(const Duration(seconds: 2));

//     if (!mounted) return;

//     setState(() => _isLoading = false);

//     // TODO: Navigate to Verification Screen
//   }

//   void _handleGoogleSignUp() {
//     // TODO
//   }

//   void _handleAppleSignUp() {
//     // TODO
//   }

//   void _handleLoginTap() {
//     Navigator.of(context).maybePop();
//   }

//   String? _validateFullName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your full name';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your email address';
//     }

//     final emailRegex =
//         RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');

//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Please enter a valid email address';
//     }

//     return null;
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your phone number';
//     }

//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     }

//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }

//     return null;
//   }

//   String? _validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     }

//     if (value != _passwordController.text) {
//       return 'Passwords do not match';
//     }

//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AuthColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(24, 8, 90, 0),
//                     child: const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 48),
//                         AuthLogo(size: 56),
//                       ],
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Image.asset(
//                       'assets/images/athlete.png',
//                       height: 210,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   Positioned(
//                     top: 8,
//                     left: 12,
//                     child: AuthBackButton(
//                       onPressed: () {
//                         Navigator.of(context).maybePop();
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               Padding(
//                 padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const CreateAccountHeader(),

//                     const SizedBox(height: 20),

//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           FullNameTextField(
//                             controller: _fullNameController,
//                             validator: _validateFullName,
//                           ),

//                           const SizedBox(height: 14),

//                           EmailTextField(
//                             controller: _emailController,
//                             validator: _validateEmail,
//                           ),

//                           const SizedBox(height: 14),

//                           PhoneTextField(
//                             controller: _phoneController,
//                             validator: _validatePhone,
//                           ),

//                           const SizedBox(height: 14),

//                           PasswordTextField(
//                             controller: _passwordController,
//                             validator: _validatePassword,
//                           ),

//                           const SizedBox(height: 14),

//                           PasswordTextField(
//                             controller: _confirmPasswordController,
//                             validator: _validateConfirmPassword,
//                             hintText: 'Confirm Password',
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     LoginButton(
//                       label: 'SIGN UP',
//                       onPressed: _handleSignUp,
//                       isLoading: _isLoading,
//                     ),

//                     const SizedBox(height: 24),

//                     const AuthDivider(
//                       label: 'OR SIGN UP WITH',
//                     ),

//                     const SizedBox(height: 20),

//                     SocialLogin(
//                       onGooglePressed: _handleGoogleSignUp,
//                       onApplePressed: _handleAppleSignUp,
//                     ),

//                     const SizedBox(height: 20),

//                     LoginText(
//                       onLoginTap: _handleLoginTap,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }