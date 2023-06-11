import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  // const CustomAppbar({
  //   super.key,
  //   required this.title,
  //   this.actions,
  //   this.leading,
  //   this.centerTitle,
  //   this.backgroundColor,
  //   this.titleTextStyle,
  // });

  // final String title;
  // final List<Widget>? actions;
  // final Widget? leading;
  // final bool? centerTitle;
  // final Color? backgroundColor;
  // final TextStyle? titleTextStyle;

  final bool isCenterTitle;
  final bool automaticallyImplyLeading;

  final Color backgroundColor;
  final Color titleColor;

  final double toolbarHeight;
  final double titleSpacing;
  final double elevation;
  final double bottomSize;

  final String title;
  final Widget? bottom;
  final List<Widget> actions;

  final Color leadingColor;
  final Function()? onLeadingAction;

  const CustomAppbar({
    super.key,
    this.isCenterTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor = const Color(0xff59D9CC),
    this.titleColor = Colors.white,
    this.leadingColor = Colors.white,
    this.toolbarHeight = 60,
    this.titleSpacing = 15,
    this.elevation = 0,
    this.bottomSize = 45,
    required this.title,
    this.bottom,
    this.actions = const [],
    this.onLeadingAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: AppBar(
          centerTitle: isCenterTitle,
          backgroundColor: backgroundColor,
          elevation: elevation,
          toolbarHeight: toolbarHeight,
          titleSpacing: titleSpacing,
          automaticallyImplyLeading: false,
          title: Text(
            title,
            style:
                TextStyles.titleBold.copyWith(color: titleColor, fontSize: 16),
          ),
          bottom: bottom != null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(bottomSize),
                  child: bottom!,
                )
              : null,
          actions: actions,
          leading: (automaticallyImplyLeading && Navigator.of(context).canPop())
              ? AppBackButton(
                  iconColor: leadingColor,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBackButton extends StatelessWidget {
  final Color iconColor;

  const AppBackButton({
    super.key,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.chevron_left_rounded,
        color: iconColor,
        size: 35,
      ),
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
