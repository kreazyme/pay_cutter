import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/generated/assets.gen.dart';

class DetailProfileWidget extends StatelessWidget {
  const DetailProfileWidget({
    super.key,
    required this.name,
    this.imageURL,
  });

  final double _height = 100;
  final String name;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(
          height: 12,
          color: Colors.transparent,
        ),
        CircleAvatar(
          radius: _height / 2,
          backgroundColor: Colors.grey,
          child: imageURL != null
              ? Image.network(
                  imageURL!,
                  fit: BoxFit.cover,
                )
              : Assets.images.imgAvatarDefault.image(
                  height: _height,
                  width: _height,
                  fit: BoxFit.cover,
                ),
        ),
        const Divider(
          height: 12,
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name,
                textAlign: TextAlign.end,
                style: TextStyles.titleBold.copyWith(
                  color: AppColors.textColor,
                )),
            const VerticalDivider(
              width: 8,
              color: Colors.transparent,
            ),
            IconButton(
              onPressed: () {
                log('Edit name');
              },
              icon: const Icon(Icons.edit),
            )
          ],
        ),
        const Divider(
          height: 12,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
