import 'package:flutter/material.dart';
import 'package:pay_cutter/generated/assets.gen.dart';

class LoginTopWidget extends StatelessWidget {
  const LoginTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.logo.imgSplash.image(
            width: 300,
            height: 350,
          ),
          const Divider(
            height: 50,
            color: Colors.transparent,
          ),
          // Text(
          //   'Tracking your money',
          //   style: TextStyles.h1.copyWith(
          //     color: AppColors.textColor,
          //   ),
          // )
        ],
      ),
    );
  }
}
