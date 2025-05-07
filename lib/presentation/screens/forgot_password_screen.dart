import 'package:android_hms/presentation/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:android_hms/core/services/Auth/api_sendOTP.dart';
import 'change_password_screen.dart'; 

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
          builder: (context) => ChangePasswordScreen(email: email),
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
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await sendOTP(context);
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
