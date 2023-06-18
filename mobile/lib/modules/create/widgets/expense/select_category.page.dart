import 'package:flutter/material.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/data/models/category.model.dart';
import 'package:pay_cutter/modules/create/widgets/expense/item_select_category.widget.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({
    super.key,
    required this.listCategory,
    required this.groupId,
  });

  final List<CategoryModel> listCategory;
  final int groupId;

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  List<CategoryModel> listCategory = [];

  @override
  void initState() {
    super.initState();
    listCategory = widget.listCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Select category',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Builder(
          builder: (context) {
            if (widget.listCategory.isEmpty) {
              return const Center(
                child: Text('No category found'),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0 || index == widget.listCategory.length + 1) {
                  return const SizedBox(
                    height: 20,
                  );
                } else {
                  return ItemSelectCategory(
                    item: widget.listCategory[index - 1],
                    onTap: (item) {
                      Navigator.pop(context, item);
                    },
                  );
                }
              },
              separatorBuilder: (context, index) => const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              itemCount: widget.listCategory.length + 2,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Object? result = await Navigator.pushNamed(
            context,
            AppRouters.createCategory,
            arguments: widget.groupId,
          );
          if (result != null) {
            setState(() {
              listCategory.add(result as CategoryModel);
            });
          }
        },
        child: const CustomIcon(iconData: Icons.add),
      ),
    );
  }
}
