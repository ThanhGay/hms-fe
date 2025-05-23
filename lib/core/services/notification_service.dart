import 'package:android_hms/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _fcm = FirebaseMessaging.instance;
  // final _androidChannel = const AndroidNotificationChannel(
  //   "high_importance_channel",
  //   "High Importance Notifications",
  //   description: "This channel is used for important notification",
  //   importance: Importance.defaultImportance,
  // );

  // final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handlerBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print(("Payload: ${message.data}"));
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      "/home",
      arguments: {"initialTabIndex": 4},
    );
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);
    // FirebaseMessaging.onMessage.listen((message) {
    //   final notification = message.notification;

    //   if (notification == null) return;
    //   _localNotifications.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         _androidChannel.id,
    //         _androidChannel.name,
    //         channelDescription: _androidChannel.description,
    //         icon: '@drawable/ic_launcher',
    //       ),
    //     ),
    //     payload: jsonEncode(message.toMap()),
    //   );
    // });
  }

  // Future<void> initLocalNotifications() async {
  //   const iOS = DarwinInitializationSettings();
  //   const android = AndroidInitializationSettings('@drawable/ic_launcher');
  //   const setting = InitializationSettings(android: android, iOS: iOS);

  //   await _localNotifications.initialize(setting,
  //       onDidReceiveNotificationResponse: (response) {
  //     final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
  //     handleMessage(message);
  //   });
  //   final platform = _localNotifications.resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>();
  //   await platform?.createNotificationChannel(_androidChannel);
  // }

  Future<void> initNotifiactions() async {
    await _fcm.requestPermission();
    final fCMToken = await _fcm.getToken();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceToken', fCMToken!);
    print("Token device: ${fCMToken}");
    print("Token device2: ${prefs.getString("deviceToken")}");
    initPushNotifications();
    // initLocalNotifications();
  }
}
