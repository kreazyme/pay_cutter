import 'package:flutter/material.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/generated/assets.gen.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.url,
    this.isBorder = false,
    this.radius = 200,
    this.height = 24,
    this.width = 24,
  });

  final String? url;
  final bool? isBorder;
  final double radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: url.isNullOrEmpty
            ? const DecorationImage(
                // image: Assets.images.imgAvatarDefault.image(
                //   fit: BoxFit.cover,
                //   height: height,
                //   width: width,
                // )
                image: AssetImage('assets/images/img_avatar_default.png'),
              )
            : DecorationImage(
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
