import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/data/models/category.model.dart';

class ItemSelectCategory extends StatelessWidget {
  const ItemSelectCategory({
    super.key,
    required this.item,
    required this.onTap,
  });

  final CategoryModel item;
  final Function(CategoryModel) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(item),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  item.name.substring(0, 1).toUpperCase(),
                  style: TextStyles.h1.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyles.title.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.transparent,
                ),
                Text(
                  item.description,
                  style: TextStyles.subTitle.copyWith(
                    color: AppColors.disableColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
