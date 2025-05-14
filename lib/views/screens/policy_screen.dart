import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  bool _isAgreed = false; // Biến để lưu trạng thái checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Điều khoản và Chính sách'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề chính
            Text(
              "Chính sách Hoàn tiền và Điều khoản sử dụng",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Mô tả chính sách
            Text(
              "Đặt phòng của bạn không được hoàn tiền nếu bạn hủy. Các khoản thanh toán đã thực hiện không thể hoàn lại dưới bất kỳ hình thức nào. Vui lòng xem các điều khoản và chính sách dưới đây trước khi xác nhận đặt phòng.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Tiêu đề cho điều khoản
            Text(
              "Điều khoản sử dụng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Chi tiết các điều khoản
            Text(
              "1. Đặt phòng cần phải tuân thủ các điều khoản và quy định của khách sạn.\n"
              "2. Bạn có thể thay đổi đặt phòng của mình nếu chưa thanh toán.\n"
              "3. Bạn phải cung cấp thông tin chính xác khi đặt phòng.\n"
              "4. Mọi thay đổi hoặc hủy bỏ cần được thực hiện trong vòng 48 giờ trước ngày nhận phòng.\n"
              "5. Các khoản thanh toán không thể hoàn lại sau khi đặt phòng.\n",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Tiêu đề cho phần lưu ý
            Text(
              "Lưu ý Quan trọng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            // Lưu ý chính sách
            Text(
              "1. Chính sách này có thể thay đổi mà không thông báo trước.\n"
              "2. Vui lòng liên hệ với chúng tôi nếu có bất kỳ thắc mắc nào về chính sách này.\n"
              "3. Chúng tôi không chịu trách nhiệm đối với những thay đổi do tình huống bất khả kháng.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),

            // Tiêu đề cho phần đồng ý
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAgreed = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "Tôi đã đọc và đồng ý với các điều khoản và chính sách trên.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Nút đồng ý hoặc quay lại
            Center(
              child: ElevatedButton(
                onPressed: _isAgreed
                    ? () {
                        Navigator.pop(context); 
                      }
                    : null, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Đồng ý",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
