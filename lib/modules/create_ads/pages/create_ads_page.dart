import 'package:divar/backend/model/category_model.dart';
import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/helpers/widgets/appbar_widget.dart';
import 'package:divar/helpers/widgets/button_widget.dart';
import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/helpers/widgets/textfield_widget.dart';
import 'package:divar/modules/auth/widgets/select_city_widget.dart';
import 'package:divar/modules/auth/widgets/select_province_widget.dart';
import 'package:divar/modules/create_ads/controller/create_ads_controller.dart';
import 'package:divar/modules/create_ads/widgets/select_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateAdsPage extends StatelessWidget {
  const CreateAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAdsController>(
      init: CreateAdsController(),
      builder: (CreateAdsController controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const AppbarWidget(title: 'ایجاد آگهی'),
                  const H(18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: <Widget>[
                            TextFieldWidget(
                              hintText: 'عنوان آگهی را وارد کنید',
                              validator: controller.titleValidator,
                              textEditingController:
                                  controller.txtTitleAdController,
                            ),
                            const H(12),
                            TextFieldWidget(
                              hintText: 'دسته بندی آگهی را انتخاب کنید',
                              disibled: true,
                              textEditingController:
                                  controller.txtCategoryController,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectCategoryWidget(
                                      listCategory: controller
                                          .categoriesResponse!.listCategory!,
                                      onSelected: (
                                        CategoryModel category,
                                      ) =>
                                          controller.onSelectCategory(category),
                                    );
                                  },
                                );
                              },
                            ),
                            const H(12),
                            TextFieldWidget(
                              hintText: 'توضیحات آگهی را وارد کنید',
                              maxlines: 3,
                              textEditingController:
                                  controller.txtDescriptionController,
                              validator: controller.descriptionValidator,
                            ),
                            const H(12),
                            TextFieldWidget(
                              hintText: 'قیمت آگهی را وارد کنید',
                              keyboardType: TextInputType.number,
                              textEditingController:
                                  controller.txtPriceController,
                              validator: controller.priceValidator,
                            ),
                            const H(12),
                            TextFieldWidget(
                              hintText: 'تصویر آگهی را انتخاب کنید',
                              disibled: true,
                              icon: Iconsax.gallery,
                              textEditingController:
                                  controller.txtImageController,
                              onTap: () {
                                controller.selectImage();
                              },
                            ),
                            const H(12),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SelectProvinceWidget(
                                            listProvince: controller
                                                .provincesResponse!
                                                .listProvinces!,
                                            onSelected: (
                                              ProvincesModel province,
                                            ) =>
                                                controller
                                                    .onSelectProvince(province),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            controller.selectedProvince == null
                                                ? 'استان'
                                                : controller.selectedProvince
                                                        ?.name ??
                                                    '',
                                            style:
                                                controller.selectedProvince ==
                                                        null
                                                    ? TextStyle(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize: 14,
                                                      )
                                                    : const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const W(19),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.selectedProvince != null) {
                                        FocusScope.of(context).unfocus();
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SelectCityWidget(
                                              province:
                                                  controller.selectedProvince!,
                                              onSelected: (
                                                CitiesModel city,
                                              ) =>
                                                  controller.onSelectCity(city),
                                            );
                                          },
                                        );
                                      } else {
                                        errorMessage(
                                            'لطفا اول استان خود را انتخاب کنید');
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            controller.selectedCity == null
                                                ? 'شهر'
                                                : controller
                                                        .selectedCity?.name ??
                                                    '',
                                            style:
                                                controller.selectedCity == null
                                                    ? TextStyle(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize: 14,
                                                      )
                                                    : const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ButtonWidget(
                              title: 'ثبت آگهی',
                              onPressed: () {
                                controller.createAds();
                              },
                              loading: controller.loading,
                            ),
                            const H(80),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
