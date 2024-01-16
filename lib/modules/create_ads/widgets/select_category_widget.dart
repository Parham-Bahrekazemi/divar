import 'package:divar/backend/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget(
      {super.key, required this.listCategory, required this.onSelected});

  final List<CategoryModel> listCategory;

  final Function(CategoryModel category) onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        height: 400,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: listCategory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSelected(listCategory[index]);
                Get.back();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      listCategory[index].name ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
