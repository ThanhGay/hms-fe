import 'package:android_hms/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController citizenIdentityController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ReEnterPasswordController =
      TextEditingController();

  SignupScreen({super.key});

  Future<void> registerUser(BuildContext context) async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final phoneNumber = phoneNumberController.text;
    final citizenIdentity = citizenIdentityController.text;
    final dateOfBirth = dateOfBirthController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final ReEnterPassword = ReEnterPasswordController.text;
    final url =
        Uri.parse("${GlobalData.api}add-customer"); // Thay bằng URL API thực tế
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "passWord": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "citizenIdentity": citizenIdentity,
        "dateOfBirth": dateOfBirth
      }),
    );
    if (password == ReEnterPassword) {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Registration successful! Welcome ${data['username']}')),
        );
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed! Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mật khẩu không trùng nhau.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            TextField(
              controller: ReEnterPasswordController,
              decoration: InputDecoration(
                labelText: 'Nhập lại mật khẩu',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: citizenIdentityController,
              decoration: InputDecoration(
                labelText: 'Căn cước công dân',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'ngày/tháng/năm sinh',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await registerUser(context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
