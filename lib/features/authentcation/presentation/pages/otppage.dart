import 'package:flutter/material.dart';

import '../otpwidget/otp_widget.dart';
import '../otpwidget/resend.dart';
import '../otpwidget/verify_buttton.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({
    super.key,
    required this.email,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B0B0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              /// Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),

              const Spacer(),

              /// Shield Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(.08),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.deepOrange,
                  size: 55,
                ),
              ),

              const SizedBox(height: 30),

              /// Title
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Verify Your ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: "Email",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "We've sent a demo verification code to",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.email,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Enter the demo code below to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              /// OTP Widget
              OtpWidget(
                onCompleted: (code) {
                  setState(() {
                    otpCode = code;
                  });
                },
              ),

              const SizedBox(height: 35),

              /// Resend
              ResendCode(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Demo OTP is 123456",
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 35),

              /// Verify Button
              VerifyButton(
                onPressed: () {
                  if (otpCode == "123456") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Demo OTP Verified Successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Invalid OTP",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.white38,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Your data is 100% secure",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}