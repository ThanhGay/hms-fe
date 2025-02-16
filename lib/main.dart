import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/screens/home_screen_bottom.dart';
import 'package:android_hms/presentation/screens/login_screen.dart';
import 'package:android_hms/presentation/screens/signup_screen.dart';
import 'package:android_hms/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/welcome_screen.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HotelProvider()),
      ChangeNotifierProvider(create: (_) => RoomProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      home: RoomDetailScreen(roomId: 0), 

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
              builder: (context) => HomeScreenBottom(
                user: args ??
                    User("https://i.imgur.com/BoN9kdC.png", "", 0, "none",
                        "guest@example.com"),
              ),
            );

          case '/room_detail':
            final roomId = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) => RoomDetailScreen(roomId: roomId ?? 0),
            );

          default:
            return null;
        }
      },
    );
  }
}
