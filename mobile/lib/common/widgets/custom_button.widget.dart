import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.content,
    this.onPressed,
    this.color,
    this.textStyle,
    this.isDiable,
    this.icon,
  }) : super(key: key);

  final Function? onPressed;
  final String content;
  final TextStyle? textStyle;
  final Color? color;
  final bool? isDiable;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () =>
          (isDiable == true || onPressed == null) ? null : onPressed!(),
      color: isDiable == true
          ? AppColors.disableColor
          : color ?? AppColors.primaryColor,
      child: Row(children: [
        if (icon != null) icon!,
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
          ).merge(textStyle),
        )
      ]),
    );
  }
}
