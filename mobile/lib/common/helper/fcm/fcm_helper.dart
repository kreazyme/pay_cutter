import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupMessage() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final String? token = await firebaseMessaging.getToken();
  log('token: $token');
  // NotificationSettings settings = await firebaseMessaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // if (settings.authorizationStatus == AuthorizationStatus.denied) {
  //   log('User granted permission');
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     log('onMessage: $message');
  //     PushNotification notification = PushNotification(
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //     );
  //   });
  // } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   log('User granted provisional permission');

  // } else {
  //   log('User declined or has not accepted permission');
  // }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      log('message: $message');
    }
  });
}
