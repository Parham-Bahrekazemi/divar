import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/categories/controller/categories_controller.dart';
import 'package:divar/modules/categories/widgets/categories_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategortController>(
      init: CategortController(),
      builder: (CategortController controller) {
        return Scaffold(
          body: SafeArea(
            child: controller.categoriesResponse == null
                ? const LoadingWidget()
                : Column(
                    children: <Widget>[
                      const H(31),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23),
                          child: ListView.builder(
                            itemCount: controller
                                    .categoriesResponse?.listCategory?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryItemWidget(
                                categoryModel: controller
                                    .categoriesResponse?.listCategory?[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
