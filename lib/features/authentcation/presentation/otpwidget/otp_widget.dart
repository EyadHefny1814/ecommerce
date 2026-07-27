import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.onCompleted,
  });

  final Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: Colors.orange,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 70,
        fieldWidth: 55,
        activeColor: Colors.orange,
        selectedColor: Colors.orange,
        inactiveColor: Colors.white24,
        activeFillColor: const Color(0xFF1A1A1A),
        selectedFillColor: const Color(0xFF1A1A1A),
        inactiveFillColor: const Color(0xFF1A1A1A),
      ),
      enableActiveFill: true,
      onChanged: (value) {},
      onCompleted: onCompleted,
    );
  }
}