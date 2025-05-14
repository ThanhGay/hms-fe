import 'package:android_hms/views/component/text_Poppins.dart';
import 'package:android_hms/core/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VoucherCard extends StatefulWidget {
  final String discount;
  final String code;
  final DateTime expiryDate;

  const VoucherCard({
    super.key,
    required this.discount,
    required this.code,
    required this.expiryDate,
  });

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 180,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 84, 66),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background hình ảnh bên trái
          ClipPath(
            clipper: LeftDiagonalClipper(),
            child: Container(
              width: 350,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/logo_app.png",
                  height: 300,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Dữ liệu bên phải
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextPoppins(
                    title: "Voucher discount: ${widget.discount}",
                    size: 24,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  TextPoppins(
                    title:
                        "Hạn sử dụng: ${DateFormat('dd/MM/yyyy').format(widget.expiryDate)}",
                    size: 16,
                    weight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: "${widget.code}"));
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text("Đã sao chép mã: ${widget.code}"),
                      //     duration: const Duration(seconds: 2),
                      //   ),
                      // );
                      showToast(
                        msg: ("Đã sao chép mã: ${widget.code}"),
                        backgroundColor: Colors.green[400],
                        textColor: Colors.white);
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text("Sao chép mã"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFF25341),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextPoppins(
                    title: "Mã voucher: ${widget.code}",
                    size: 18,
                    color: Colors.white,
                    weight: FontWeight.w500,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🎨 Cắt phần bên trái theo đường chéo
class LeftDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.2, 0) // Chia phần trái khoảng 60%
      ..lineTo(size.width * 0.6, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 8,
//       shadowColor: Colors.orangeAccent,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               gradient: const LinearGradient(
//                 colors: [Colors.orange, Colors.deepOrange],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Icon giảm giá
//                 const Icon(Icons.local_offer, size: 50, color: Colors.white),
//                 const SizedBox(height: 8),

//                 // Mức giảm giá
//                 Text(
//                   discount,
//                   style: GoogleFonts.pacifico(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // Phần mã giảm giá
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     code,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.5,
//                       color: Colors.deepOrange,
//                     ),
//                   ),
//                 ),

//                 // Đường cắt chấm
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       20,
//                       (index) => Container(
//                         width: 6,
//                         height: 2,
//                         margin: const EdgeInsets.symmetric(horizontal: 2),
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Ngày hết hạn
//                 Text(
//                   expiryDate,
//                   style: const TextStyle(color: Colors.white70, fontSize: 14),
//                 ),

//                 const SizedBox(height: 15),

//                 // Nút sao chép mã
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Clipboard.setData(ClipboardData(text: code));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Đã sao chép mã: $code"),
//                         duration: const Duration(seconds: 2),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.copy),
//                   label: const Text("Sao chép mã"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepOrange,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Hiệu ứng bo góc kiểu ticket
//           Positioned(
//             left: -10,
//             top: 60,
//             child: _circleCut(),
//           ),
//           Positioned(
//             right: -10,
//             top: 60,
//             child: _circleCut(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _circleCut() {
//     return Container(
//       width: 20,
//       height: 20,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }
