import 'package:android_hms/presentation/component/base/InputTextField.dart';
import 'package:android_hms/presentation/screens/login_screen.dart';
import 'package:android_hms/presentation/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:android_hms/core/services/Auth/api_reset_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ChangePasswordScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  Future<void> resetPassword() async {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu không khớp')),
      );
      return;
    }

    final response = await ApiResetPassword.resetPassword(
      widget.email,
      widget.otp,
      password,
    );

    if (response == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Đổi mật khẩu thành công! Vui lòng đăng nhập.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else if (response == 400) {
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to reset password. Please try again.')),
      // );
      showToast(
        msg: ('Failed to reset password. Please try again.'),
        backgroundColor: Colors.red[400],
        textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputTextField(
              controller: passwordController,
              obscureText: obscurePassword,
              labelText: 'Mật khẩu mới',
              hintText: 'Nhập mật khẩu mới',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: togglePasswordVisibility,
              ),
            ),
            const SizedBox(height: 10),
            InputTextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              labelText: 'Xác nhận mật khẩu',
              hintText: 'Nhập lại mật khẩu mới',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: toggleConfirmPasswordVisibility,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetPassword,
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}
