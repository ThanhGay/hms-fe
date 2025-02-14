import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/screens/home_screen_bottom.dart';
import 'package:android_hms/presentation/screens/login_screen.dart';
import 'package:android_hms/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());

          case '/register':
            return MaterialPageRoute(builder: (context) => SignupScreen());

          case '/home':
            // Nhận dữ liệu từ arguments
            final args = settings.arguments as User?;

            return MaterialPageRoute(
              builder: (context) => HomeScreen(
                user: args ??
                    User("https://i.imgur.com/BoN9kdC.png", "", 0, "none",
                        "guest@example.com"),
              ),
            );

          default:
            return null;
        }
      },
    );
  }
}
