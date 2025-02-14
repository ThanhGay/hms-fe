import 'dart:convert';

import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/screens/info_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (user.name.isEmpty) {
      return ProfileDefault();
    } else {
      return ProfileWithUser(user: user);
    }
  }
}

class ProfileDefault extends StatelessWidget {
  const ProfileDefault({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Text('Log in to start planning your next trip'),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size.fromWidth(200),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Row(
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () async {
                          // Navigator.pushNamed(context, '/register');
                          final prefs = await SharedPreferences.getInstance();
                          String? jsonData = prefs.getString('user');
                          Map<String, dynamic> user =
                              json.decode(jsonData!); // Chuyển lại thành Map
                          print(
                              'Data ${user['firstName']} ${user['lastName']}');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Settings'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Accessibility'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.home_sharp),
                      title: Text('Learn about hosting'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('Get help'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Term of Service'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Version 25.01')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileWithUser extends StatelessWidget {
  const ProfileWithUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            SizedBox(height: 16),
            InfoCard(icon: Icons.person, title: "Họ và Tên", value: user.name),
            InfoCard(
                icon: Icons.cake, title: "Tuổi", value: user.age.toString()),
            InfoCard(
                icon: Icons.location_on, title: "Địa chỉ", value: user.address),
            InfoCard(icon: Icons.email, title: "Email", value: user.email),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Chức năng đang phát triển")),
                );
              },
              child: Text("Chỉnh sửa"),
            ),
          ],
        ),
      ),
    );
  }
}
