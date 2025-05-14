import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:android_hms/core/themes/app_theme.dart';
import 'package:android_hms/services/notification_service.dart';

import 'package:android_hms/views/storages/room_provider.dart';
import 'package:android_hms/views/storages/hotel_provider.dart';
import 'package:android_hms/views/storages/voucher_provider.dart';
import 'package:android_hms/views/storages/favourite_provider.dart';

import 'package:android_hms/views/screens/login_screen.dart';
import 'package:android_hms/views/screens/signup_screen.dart';
import 'package:android_hms/views/screens/welcome_screen.dart';
import 'package:android_hms/views/screens/otp_check_screen.dart';
import 'package:android_hms/views/screens/vote_room_screen.dart';
import 'package:android_hms/views/screens/room_detail_screen.dart';
import 'package:android_hms/views/screens/home_screen_bottom.dart';
import 'package:android_hms/views/screens/booking_review_screen.dart';
import 'package:android_hms/views/screens/forgot_password_screen.dart';
import 'package:android_hms/views/screens/change_password_screen.dart';
import 'package:android_hms/views/screens/booking_payment_screen.dart';
import 'package:android_hms/views/screens/booking_option_sheet_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initNotifiactions();
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
      navigatorKey: navigatorKey,
      // home: RoomDetailScreen(roomId: 0, hotelId: 0,),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/welcome_page':
            return MaterialPageRoute(builder: (_) => WelcomeScreen());

          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());

          case '/register':
            return MaterialPageRoute(builder: (context) => SignupScreen());

          case '/home':
            final args = settings.arguments as Map<String, int>;
            int? tabIndex = args['initialTabIndex'] ?? 0;
            return MaterialPageRoute(
                builder: (context) => HomeScreenBottom(
                      initialTabIndex: tabIndex,
                    ));

          case '/vote_room':
            final args = settings.arguments as Map<String, int>;
            final roomId = args['roomId']!;
            return MaterialPageRoute(
                builder: (context) => VoteRoomScreen(roomId: roomId));

          case '/payment':
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              final roomId = args['roomId'] ?? 0;
              final hotelId = args['hotelId'] ?? 0;
              final totalPrice = args['totalPrice'] ?? 0;
              return MaterialPageRoute(
                builder: (context) => BookingPaymentScreen(
                  roomId: roomId,
                  hotelId: hotelId,
                  totalPrice: totalPrice,
                ),
              );
            }
            return null;

          case '/forgot-password':
            return MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen());

          case '/change-password':
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(
                  email: args['email']!, otp: args['otp']!),
            );

          case '/booking_review':
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              final roomId = args['roomId'] ?? 0;
              final hotelId = args['hotelId'] ?? 0;
              return MaterialPageRoute(
                builder: (context) => BookingReviewScreen(
                  roomId: roomId,
                  hotelId: hotelId,
                ),
              );
            }
            return null;

          case '/otp-check':
            final args = settings.arguments as Map<String, String>;
            final email = args['email']!;
            return MaterialPageRoute(
              builder: (context) => OtpCheckScreen(email: email),
            );

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
