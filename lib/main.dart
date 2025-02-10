import 'package:android_hms/presentation/screens/home_screen.dart';
import 'package:android_hms/presentation/screens/login_screen.dart';
import 'package:android_hms/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'presentation/screens/welcome_screen.dart';
import 'presentation/themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       debugShowCheckedModeBanner: false,
//       home: WelcomeScreen(),
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/login':
//             return MaterialPageRoute(builder: (context) => LoginScreen());

//           case '/register':
//             return MaterialPageRoute(builder: (context) => SignupScreen());

//           case '/home':
//             // Nhận dữ liệu từ `arguments`
//             final args = settings.arguments as Map<String, dynamic>?;
//             return MaterialPageRoute(
//               builder: (context) => HomeScreen(
//                 avatarUrl:
//                     args?['avatarUrl'] ?? "https://i.imgur.com/BoN9kdC.png",
//                 name: args?['name'] ?? 'Guest',
//                 age: args?['age'] ?? 0,
//                 address: args?['address'] ?? 'none',
//                 email: args?['email'] ?? 'guest@example.com',
//               ),
//             );

//           default:
//             return null;
//         }
//       },
//     );
//   }
// }
