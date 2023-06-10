import 'package:flutter/material.dart';
import 'package:pay_cutter/generated/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Assets.logo.imgSplash.image(
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    ));
  }
}
