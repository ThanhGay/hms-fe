import 'package:android_hms/core/services/Auth/api_check_otp.dart';
import 'package:android_hms/presentation/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCheckScreen extends StatefulWidget {
  final String email;

  const OtpCheckScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpCheckScreen> createState() => _OtpCheckScreenState();
}

class _OtpCheckScreenState extends State<OtpCheckScreen> {
  String _otp = "";
  bool _isLoading = false;

  Future<void> _handleSubmitOtp() async {
    if (_otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đủ 6 số OTP")),
      );
      return;
    }

    setState(() => _isLoading = true);

    int status = await ApiCheckOTP.checkOtp(widget.email, _otp);

    setState(() => _isLoading = false);

    if (status == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xác thực OTP thành công")),
      );

      
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => ChangePasswordScreen (email: widget.email,otp: _otp),
        ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP không đúng hoặc đã hết hạn")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xác thực OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("Nhập OTP đã gửi đến email ${widget.email}"),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) => _otp = value,
              onCompleted: (value) => _otp = value,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSubmitOtp,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Xác nhận")
                  ,
            )
          ],
        ),
      ),
    );
  }
}
