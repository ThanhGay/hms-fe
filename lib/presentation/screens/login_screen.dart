import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    const String url = "${GlobalData.api}Login";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Xác định kiểu dữ liệu gửi đi
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Login successful! Welcome ${data['username']}')),
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
