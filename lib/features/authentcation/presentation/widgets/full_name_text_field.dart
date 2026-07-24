import 'package:flutter/material.dart';

class FullNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const FullNameTextField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
        hintText: 'Full Name',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}