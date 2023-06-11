import 'package:flutter/material.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/generated/assets.gen.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'About us',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(120),
          child: Assets.logo.imgSplash.image(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
