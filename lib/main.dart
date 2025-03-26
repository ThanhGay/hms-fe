import 'package:android_hms/presentation/screens/booking_option_sheet_screen.dart';
import 'package:android_hms/presentation/screens/booking_review_screen.dart';
import 'package:android_hms/Data/favourite_provider.dart';
import 'package:android_hms/Data/voucher_provider.dart';
import 'package:android_hms/presentation/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:android_hms/Data/hotel_provider.dart';
import 'package:android_hms/Data/room_provider.dart';

import 'package:android_hms/presentation/themes/app_theme.dart';
import 'package:android_hms/presentation/screens/welcome_screen.dart';
import 'package:android_hms/presentation/screens/login_screen.dart';
import 'package:android_hms/presentation/screens/signup_screen.dart';
import 'package:android_hms/presentation/screens/home_screen_bottom.dart';
import 'package:android_hms/presentation/screens/forgot_password_screen.dart';
import 'package:android_hms/presentation/screens/change_password_screen.dart';
import 'package:android_hms/presentation/screens/booking_payment_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HotelProvider()),
      ChangeNotifierProvider(create: (_) => RoomProvider()),
      ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ChangeNotifierProvider(create: (_) => VoucherProvider())
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
      // home: RoomDetailScreen(roomId: 0, hotelId: 0,),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());

          case '/register':
            return MaterialPageRoute(builder: (context) => SignupScreen());

          case '/home':
            return MaterialPageRoute(builder: (context) => HomeScreenBottom());

          case '/payment':
            return MaterialPageRoute(builder: (context) => BookingPaymentScreen());

          case '/forgot-password':
            return MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen());

          case '/change-password':
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(email: args['email']!),
            );

          case '/booking_review':
            if (settings.arguments is Map<String, int>) {
              final args = settings.arguments as Map<String, int>;
              return MaterialPageRoute(
                builder: (context) => BookingReviewScreen(
                  roomId: args['roomId']!,
                  hotelId: args['hotelId']!,
                ),
              );
            }
            return null; // Trả về null nếu không có đủ tham số

          case '/booking_option':
            return MaterialPageRoute(
                builder: (context) => BookingOptionsSheet());

          case '/room_detail':
            if (settings.arguments is Map<String, int>) {
              final args = settings.arguments as Map<String, dynamic>;
              final roomId = args['roomId'] ?? 0;
              final hotelId = args['hotelId'] ?? 0;

              return MaterialPageRoute(
                builder: (context) => RoomDetailScreen(
                  roomId: roomId,
                  hotelId: hotelId,
                ),
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
