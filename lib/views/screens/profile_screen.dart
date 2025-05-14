import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:android_hms/models/entities/user.dart';
import 'package:android_hms/views/screens/profile_screen_default.dart';
import 'package:android_hms/views/screens/profile_screen_with_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserInformation? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user');

    if (jsonData != null) {
      setState(() {
        userData = UserInformation.fromJson(jsonDecode(jsonData));
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userData == null) {
      return ProfileDefault();
    } else {
      return ProfileWithUser(user: userData!);
    }
  }
}
