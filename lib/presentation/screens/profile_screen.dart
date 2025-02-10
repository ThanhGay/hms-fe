import 'package:android_hms/presentation/screens/info_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int age;
  final String address;
  final String email;
  const ProfileScreen(
      {Key? key,
      required this.avatarUrl,
      required this.name,
      required this.age,
      required this.address,
      required this.email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông Tin Cá Nhân"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            SizedBox(height: 16),
            InfoCard(icon: Icons.person, title: "Họ và Tên", value: name),
            InfoCard(icon: Icons.cake, title: "Tuổi", value: "$age"),
            InfoCard(icon: Icons.location_on, title: "Địa chỉ", value: address),
            InfoCard(icon: Icons.email, title: "Email", value: email),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Chức năng đang phát triển")),
                );
              },
              child: Text("Chỉnh sửa"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
