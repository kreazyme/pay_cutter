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
    this.isLoading,
  }) : super(key: key);

  final Function? onPressed;
  final String content;
  final TextStyle? textStyle;
  final Color? color;
  final bool? isDiable;
  final Icon? icon;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () =>
          (isDiable == true || onPressed == null) ? null : onPressed!(),
      color: isDiable == true
          ? AppColors.disableColor
          : color ?? AppColors.primaryColor,
      height: 50,
      child: Row(children: [
        if (icon != null) icon!,
        Expanded(
          child: Text(
            isLoading == true ? 'Loading...' : content,
            style: const TextStyle(
              color: Colors.white,
            ).merge(textStyle),
            textAlign: TextAlign.center,
          ),
        )
      ]),
    );
  }
}
