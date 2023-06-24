import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupMessage() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final String? token = await firebaseMessaging.getToken();
  log('token: $token');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      log('message: $message');
    }
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message");
  RemoteNotification? notification = message.notification;
  if (notification != null) {
    log('message: $message');
  }
}
