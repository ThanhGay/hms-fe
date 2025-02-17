import 'dart:convert';

import 'package:android_hms/core/services/Auth/api_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    final response = await ApiLogin.loginUser(email, password);

    if (response == 200) {
      final prefs = await SharedPreferences.getInstance();
      String? jsonData = prefs.getString('user');
      Map<String, dynamic> user =
          json.decode(jsonData!); // Chuyển lại thành Map
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Login successful! Welcome ${user['firstName']} ${user['lastName']}')),
      );
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed! Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await loginUser(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
