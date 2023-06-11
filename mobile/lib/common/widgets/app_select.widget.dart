import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

class AppSelectWidget extends StatelessWidget {
  const AppSelectWidget({
    super.key,
    required this.onTap,
    this.title,
    this.isLoading = false,
    this.placeholder,
  });

  final Function onTap;
  final String? title;
  final String? placeholder;
  final bool isLoading;

  String get _getTitle {
    if (isLoading) {
      return 'Loading...';
    }
    return title ?? (placeholder ?? 'Select');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLoading) {
          return;
        }
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        width: double.infinity,
        height: 40,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor,
          ),
        ),
        child: Row(children: [
          Text(
            _getTitle,
            style: TextStyles.title.copyWith(
              color: (isLoading || title == null)
                  ? AppColors.disableColor
                  : AppColors.textColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_drop_down,
            color: (isLoading || title == null)
                ? AppColors.disableColor
                : AppColors.textColor,
          ),
        ]),
      ),
    );
  }
}
