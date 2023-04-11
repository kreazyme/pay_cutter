import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';

class CustomTextFielddWidget extends StatefulWidget {
  const CustomTextFielddWidget({
    required this.keyboardType,
    required this.onChanged,
    Key? key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.isPasswordField = false,
    this.textInputAction = TextInputAction.done,
    this.controller,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  @override
  State<CustomTextFielddWidget> createState() => _CustomTextFielddWidgetState();
}

class _CustomTextFielddWidgetState extends State<CustomTextFielddWidget> {
  bool isSecureTextEntry = true;

  void showPassword() {
    setState(() {
      isSecureTextEntry = !isSecureTextEntry;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '${widget.labelText}',
              // style: AppTextStyles.label
              //     .copyWith(color: AppColors.textColor),
            ),
          ),
          TextFormField(
            // style: AppTextStyles.body1
            //     .copyWith(color: AppColors.textColor),
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              errorMaxLines: 3,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: widget.isPasswordField
                  ? GestureDetector(
                      onTap: showPassword,
                      child: isSecureTextEntry
                          ? Icon(
                              Icons.visibility_off,
                              color: AppColors.textColor,
                              size: 20,
                            )
                          : Icon(
                              Icons.visibility,
                              color: AppColors.textColor,
                              size: 20,
                            ))
                  : null,
              enabled: true,
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.alertText,
                width: 1,
              )),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.alertText, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.borderColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColor, width: 1)),
              focusColor: AppColors.textColor,
              hintText: widget.hintText,
              // hintStyle: AppTextStyles.body2
              //     .copyWith(color: AppColors.borderColor),
              errorText: widget.errorText,
            ),
            textInputAction: widget.textInputAction,
            cursorColor: AppColors.textColor,
            obscureText: isSecureTextEntry && widget.isPasswordField,
            onChanged: widget.onChanged,
          )
        ],
      );
}
