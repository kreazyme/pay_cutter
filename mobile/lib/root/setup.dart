import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pay_cutter/common/helper/fcm/fcm_helper.dart';
import 'package:pay_cutter/generated/di/injector.dart';

Future<void> setupApp() async {
  await Hive.initFlutter();
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupMessage();
}
