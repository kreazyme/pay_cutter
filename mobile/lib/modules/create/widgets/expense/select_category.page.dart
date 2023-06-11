import 'package:flutter/material.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/modules/create/widgets/expense/item_select_category.widget.dart';

class SelectCategoryPage extends StatelessWidget {
  const SelectCategoryPage({
    super.key,
    required this.listCategory,
  });

  final List<CategoryModel> listCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          title: 'Select category',
        ),
        body: Builder(
          builder: (context) {
            if (listCategory.isEmpty) {
              return const Center(
                child: Text('No category found'),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) => ItemSelectCategory(
                item: listCategory[index],
                onTap: (item) {
                  Navigator.pop(context, item);
                },
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              itemCount: listCategory.length,
            );
          },
        ));
  }
}
