import 'dart:convert';
import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/screens/profile_screen_default.dart';
import 'package:android_hms/presentation/screens/profile_screen_with_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserInformation? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user');

    print('JSON Data: $jsonData');

    if (jsonData != null) {
      setState(() {
        userData = UserInformation.fromJson(jsonDecode(jsonData));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("hello profile");
    print(userData);

    if (userData == null) {
      return ProfileDefault();
    } else {
      return ProfileWithUser(user: userData!);
    }
  }
}
