import 'package:android_hms/core/services/api_create_vote.dart';
import 'package:android_hms/presentation/component/base/InputTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VoteRoomScreen extends StatefulWidget {
  final int roomId;

  const VoteRoomScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  _VoteRoomState createState() => _VoteRoomState();
}

class _VoteRoomState extends State<VoteRoomScreen> {
  double rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool isSubmitting = false;

  void _submitVote() async {
    if (rating == 0 || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn số sao và nhập đánh giá")),
      );
      return;
    }

    setState(() {
      print("Đang gửi đánh giá...");
      isSubmitting = true;
    });

    final result = await ApiCreateVote.createVote(
      widget.roomId,
      rating.toInt(),
      _commentController.text,
    );

    print("Kết quả phản hồi từ API: $result");
    setState(() {
      print("Đã gửi đánh giá xong");
      print("Kết quả: $result");
      isSubmitting = false;
    });

    if (result == "Đánh giá thành công") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Đánh giá thành công"),
          duration: Duration(seconds: 2),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đánh giá thất bại")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đánh giá phòng")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chọn số sao", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text("Nhập đánh giá", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            InputTextField(
              controller: _commentController,
              maxLines: 4,
              hintText: "Nhập đánh giá của bạn",
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isSubmitting ? null : _submitVote,
                child: isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text("Gửi đánh giá"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
