import 'package:android_hms/Api/api_signUp.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController citizenIdentityController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
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
    final reEnterPassword = reEnterPasswordController.text;
    if (password == reEnterPassword) {
      final response = await ApiSignup.signUp(email, password, firstName,
          lastName, phoneNumber, citizenIdentity, dateOfBirth);
      if (response == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful! Welcome {}')),
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
      body: SingleChildScrollView(
        child: Padding(
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
                controller: reEnterPasswordController,
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
      ),
    );
  }
}
