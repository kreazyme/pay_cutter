import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

class DetailItemButtonWidget extends StatelessWidget {
  const DetailItemButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.isWarning,
  });

  final Function onPressed;
  final String title;
  final Widget? icon;
  final bool? isWarning;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onPressed(),
      title: Text(
        title,
        style: TextStyles.subTitle.copyWith(
          color: isWarning == true ? AppColors.alertText : AppColors.textColor,
          fontWeight: FontWeight.normal,
        ),
      ),
      leading: SizedBox(
        width: 24,
        height: 24,
        child: icon ?? Container(),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
    );
  }
}
