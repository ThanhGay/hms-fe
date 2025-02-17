import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';
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
      home: WelcomeScreen(),
      // home: RoomDetailScreen(roomId: 0),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());

          case '/register':
            return MaterialPageRoute(builder: (context) => SignupScreen());

          case '/home':
            return MaterialPageRoute(
              builder: (context) => HomeScreenBottom(),
            );

          case '/room_detail':
            if (settings.arguments is Map<String, int>) {
              final args = settings.arguments as Map<String, int>;
              final roomId = args['roomId'] ?? 0;
              final hotelId = args['hotelId'] ?? 0;

              return MaterialPageRoute(
                builder: (context) =>
                    RoomDetailScreen(roomId: roomId, hotelId: hotelId),
              );
            }
            return null;

          default:
            return null;
        }
      },
    );
  }
}
