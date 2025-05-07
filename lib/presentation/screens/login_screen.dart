import 'package:android_hms/presentation/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:android_hms/core/services/Auth/api_login.dart';
import 'package:android_hms/presentation/themes/app_theme.dart';
import 'package:android_hms/presentation/component/base/InputTextField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController deviceTokenController = TextEditingController();
  bool obscurePassword = true;
  bool rememberMe = false;

  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    final devicetoken = deviceTokenController.text;

    final response = await ApiLogin.loginUser(email, password, devicetoken);

    if (response == "Success") {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Đăng nhập thành công!')),
      // );
      showToast(
        msg: ('Đăng nhập thành công!'),
        backgroundColor: Colors.green[400],
        textColor: Colors.white);
      Navigator.pushNamed(
        context,
        '/home',
        arguments: {"initialTabIndex": 0},
      );
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Đăng nhập thất bại!!!')),
      // );
      showToast(
        msg: ('Đăng nhập thất bại!!!'),
        backgroundColor: Colors.red[400],
        textColor: Colors.white);
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 60),
              // Logo
              Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Tiêu đề
              Text(
                'Đăng nhập bằng tài khoản',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textDefaultColor,
                ),
              ),
              SizedBox(height: 8),
              // Mô tả
              Text(
                'Nhập email và mật khẩu để đăng nhập',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 24),
              // Ô nhập email
              InputTextField(
                controller: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(height: 16),
              // Ô nhập mật khẩu
              InputTextField(
                controller: passwordController,
                labelText: 'Mật khẩu',
                obscureText: obscurePassword,
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Nhớ mật khẩu và Quên mật khẩu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(color: ColorConstants.secondaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Nút Đăng nhập
              ElevatedButton(
                onPressed: () async {
                  await loginUser(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Đường kẻ ngang "Or"
              Row(
                children: <Widget>[
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 24),
              // Nút Tiếp tục với Google
              OutlinedButton.icon(
                onPressed: () {
                  // Xử lý đăng nhập với Google
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.gg,
                  color: ColorConstants.secondaryColor,
                  size: 28,
                ),
                label: Text(
                  'Continue with Google',
                  style: TextStyle(
                      fontSize: 16, color: ColorConstants.textDefaultColor),
                ),
              ),
              SizedBox(height: 16),
              // Nút Tiếp tục với Facebook
              OutlinedButton.icon(
                onPressed: () {
                  // Xử lý đăng nhập với Facebook
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                icon: Icon(Icons.facebook,
                    color: ColorConstants.secondaryColor, size: 28),
                label: Text(
                  'Continue with Facebook',
                  style: TextStyle(
                      fontSize: 16, color: ColorConstants.textDefaultColor),
                ),
              ),
              SizedBox(height: 40),
              // Chưa có tài khoản? Đăng ký
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Chưa có tài khoản? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
