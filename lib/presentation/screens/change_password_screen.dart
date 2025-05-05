import 'package:flutter/material.dart';
import 'package:android_hms/core/services/Auth/api_reset_password.dart'; 

class ChangePasswordScreen extends StatelessWidget {
  final String email; 
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ChangePasswordScreen({super.key, required this.email});

  Future<void> resetPassword(BuildContext context) async {
    final otp = otpController.text;
    final password = passwordController.text;

    if (otp.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final response = await ApiResetPassword.resetPassword(email, otp, password);

    if (response == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully! Please login.')),
      );
      Navigator.pop(context); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reset password. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: email),
              enabled: false, 
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await resetPassword(context);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
