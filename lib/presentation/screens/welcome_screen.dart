import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to AirBnb',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Thêm padding bên ngoài
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home', arguments: {
                      'avatarUrl': "https://i.imgur.com/BoN9kdC.png",
                      'name': "Nguyễn Văn A",
                      'age': 25,
                      'address': "Hà Nội, Việt Nam",
                      'email': "nguyenvana@example.com",
                    });
                  },
                  child: Text('Login'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Thêm padding bên ngoài
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Register'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Thêm padding bên ngoài
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text('Bỏ qua'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
