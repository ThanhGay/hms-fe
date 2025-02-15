import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  static Future<dynamic> loginUser(
      BuildContext context, String email, String password) async {
    const url = 'https://192.168.2.4:5108/Login';

    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Login successful! Welcome ${data['username']}')),
      );
      return data;
      // Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed! Please check your credentials.')),
      );
      return null;
    }
  }
}
