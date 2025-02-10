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
            buildInfoCard(Icons.person, "Họ và Tên", name),
            buildInfoCard(Icons.cake, "Tuổi", "$age"),
            buildInfoCard(Icons.location_on, "Địa chỉ", address),
            buildInfoCard(Icons.email, "Email", email),
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

  Widget buildInfoCard(IconData icon, String title, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
