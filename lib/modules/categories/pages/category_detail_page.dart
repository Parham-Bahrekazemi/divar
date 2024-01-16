import 'package:divar/backend/model/category_model.dart';
import 'package:divar/helpers/widgets/ads_item_widget.dart';
import 'package:divar/helpers/widgets/appbar_widget.dart';
import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/modules/categories/controller/categories_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key, required this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    Get.find<CategortController>()
        .getAdsByCategory(widget.categoryModel!.id.toString());

    super.initState();
  }

  @override
  void dispose() {
    Get.find<CategortController>().adResponse = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategortController>(
      builder: (CategortController controller) {
        bool isNotEmptyList = controller.adResponse?.adModelList != null &&
            controller.adResponse!.adModelList!.isNotEmpty;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                AppbarWidget(
                  title: widget.categoryModel?.name ?? '',
                ),
                controller.adResponse == null
                    ? const Expanded(child: LoadingWidget())
                    : isNotEmptyList
                        ? Expanded(
                            child: AdsItemWidget(
                              adModelList: controller.adResponse?.adModelList,
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                'آگهی مورد نظر یافت نشد',
                                style: context.textTheme.titleLarge,
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
