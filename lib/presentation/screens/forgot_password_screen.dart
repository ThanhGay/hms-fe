import 'package:android_hms/presentation/component/base/InputTextField.dart';
import 'package:android_hms/presentation/screens/otp_check_screen.dart';
import 'package:android_hms/presentation/themes/app_theme.dart';
import 'package:android_hms/presentation/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:android_hms/core/services/Auth/api_sendOTP.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  Future<void> sendOTP(BuildContext context) async {
    final email = emailController.text;

    if (email.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Please enter your email')),
      // );
      showToast(
        msg: ('Please enter your email'),
        backgroundColor: Colors.orange[400],
        textColor: Colors.white);
      return;
    }

    final response = await ApiSendOTP.sendOtp(email);

    if (response == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('OTP has been sent to your email!')),
      // );
      showToast(
        msg: ('OTP has been sent to your email!'),
        backgroundColor: Colors.green[400],
        textColor: Colors.white);
      Navigator.push(
     context,
        MaterialPageRoute(
          builder: (context) =>OtpCheckScreen (email: email),
        ),   
      );
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to send OTP. Please try again.')),
      // );
      showToast(
        msg: ('Failed to send OTP. Please try again.'),
        backgroundColor: Colors.red[400],
        textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputTextField(
              controller: emailController,
              labelText: 'Nhập email của bạn',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await sendOTP(context);
              },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                 child: Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
