import 'package:flutter/material.dart';
import 'package:android_hms/core/services/Auth/api_signUp.dart';
import 'package:android_hms/presentation/component/base/InputTextField.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  DateTime? selectedDate; // Lưu trữ ngày đã chọn
  bool obscurePassword = true;
  bool obscureRepassword = true;

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateOfBirthController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });
    }
  }

  // ẩn/hiện mật khẩu
  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  // ẩn/hiện nhập lại mật khẩu
  void toggleRePasswordVisibility() {
    setState(() {
      obscureRepassword = !obscureRepassword;
    });
  }

  Future<void> registerUser(BuildContext context) async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final phoneNumber = phoneNumberController.text;
    final citizenIdentity = citizenIdentityController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final reEnterPassword = reEnterPasswordController.text;

    if (password == reEnterPassword) {
      // Chuyển đổi ngày sinh sang 'YYYY-MM-DD'
      final dateOfBirth = selectedDate != null
          ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
          : '';

      final response = await ApiSignup.signUp(email, password, firstName,
          lastName, phoneNumber, citizenIdentity, dateOfBirth);
      if (response == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công!')),
        );
        Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Đăng ký thất bại! ${response}, vui lòng thử lại!!!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu không trùng nhau.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Đăng ký'),
        backgroundColor: Colors.blue.shade100,
        iconTheme: const IconThemeData(color: Colors.blue),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Tiêu đề
              const Text(
                'Tạo tài khoản',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Mô tả
              Text(
                'Vui lòng cung cấp những thông tin sau \n để tạo tài khoản mới',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Ô nhập Họ
              InputTextField(
                controller: firstNameController,
                labelText: 'Họ',
              ),
              const SizedBox(height: 16),
              // Ô nhập Tên
              InputTextField(
                controller: lastNameController,
                labelText: 'Tên',
              ),
              const SizedBox(height: 16),
              // Ô nhập Email
              InputTextField(
                controller: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Ô nhập Mật khẩu
              InputTextField(
                controller: passwordController,
                labelText: 'Mật khẩu',
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              const SizedBox(height: 16),
              // Ô nhập lại Mật khẩu
              InputTextField(
                controller: reEnterPasswordController,
                labelText: 'Nhập lại mật khẩu',
                hintText: 'Nhập lại mật khẩu',
                obscureText: obscureRepassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureRepassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: toggleRePasswordVisibility,
                ),
              ),
              const SizedBox(height: 16),
              // Ô nhập Số điện thoại
              InputTextField(
                controller: phoneNumberController,
                labelText: 'Số điện thoại',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              // Ô nhập Căn cước công dân
              InputTextField(
                controller: citizenIdentityController,
                labelText: 'Căn cước công dân',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Ô nhập Ngày sinh
              InputTextField(
                controller: dateOfBirthController,
                labelText: 'Ngày sinh',
                hintText: 'DD/MM/YYYY',
                readOnly: true,
                onTap: () => selectDate(context),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
              const SizedBox(height: 32),
              // Nút Đăng ký
              ElevatedButton(
                onPressed: () async {
                  await registerUser(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Đã có tài khoản? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Đăng nhập',
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
