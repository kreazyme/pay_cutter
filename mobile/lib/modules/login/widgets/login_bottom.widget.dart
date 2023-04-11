import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/generated/assets.gen.dart';
import 'package:pay_cutter/modules/login/bloc/login.bloc.dart';

class LoginBottomWidget extends StatelessWidget {
  const LoginBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          const Divider(
            height: 40,
            color: Colors.transparent,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(
                      LoginGoogle(),
                    );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.icons.icGoogle.image(
                    width: 30,
                    height: 30,
                  ),
                  const VerticalDivider(
                    width: 10,
                    color: Colors.transparent,
                  ),
                  Text(
                    'Login with Google',
                    style:
                        TextStyles.title.copyWith(color: AppColors.textColor),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
