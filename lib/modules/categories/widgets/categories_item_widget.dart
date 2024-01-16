import 'package:divar/backend/model/category_model.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/modules/categories/pages/category_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CategoryDetailPage(
          categoryModel: categoryModel,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 10,
              color: const Color(0xff000000).withOpacity(0.1),
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            const W(14),
            Image.network(
              categoryModel?.image ?? '',
            ),
            const W(13),
            Text(
              categoryModel?.name ?? '',
              style: context.textTheme.titleMedium,
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
            ),
            const W(16),
          ],
        ),
      ),
    );
  }
}
