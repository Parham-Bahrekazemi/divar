import 'package:divar/helpers/widgets/loading_widget.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/modules/create_ads/pages/create_ads_page.dart';

import 'package:divar/modules/home/controller/home_controller.dart';
import 'package:divar/modules/categories/pages/categories_page.dart';
import 'package:divar/modules/home/pages/dashboard_page.dart';
import 'package:divar/modules/home/widgets/select_city_dialog.dart';
import 'package:divar/modules/profile/pages/profile_page.dart';
import 'package:divar/modules/search/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 15,
                        spreadRadius: 0,
                        color: const Color(0xff000000).withOpacity(0.07),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      alignment: Alignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: double.infinity,
                        ),
                        Positioned(
                          right: 0,
                          child: Column(
                            children: <Widget>[
                              PopupMenuButton(
                                onSelected: (SortProduct value) {
                                  if (controller.currentindex == 0) {
                                    controller.sortAd(value);
                                  } else {
                                    errorMessage('لطفا به صفحه خانه بروید');
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      value: SortProduct(
                                        orderC: 'id',
                                        orderT: 'DESC',
                                        title: 'جدیدترین',
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffDEDEDE),
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: const Center(
                                          child: Text(
                                            'جدیدترین',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: SortProduct(
                                        orderC: 'discount',
                                        orderT: 'DESC',
                                        title: 'بیشترین تخفیف',
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffDEDEDE),
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: const Center(
                                          child: Text(
                                            'بیشترین تخفیف',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: SortProduct(
                                          orderC: 'price',
                                          orderT: 'ASC',
                                          title: 'ارزانترین'),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffDEDEDE),
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: const Center(
                                          child: Text(
                                            'ارزانترین',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: SortProduct(
                                        orderC: 'price',
                                        orderT: 'DESC',
                                        title: 'گرانترین',
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: const Center(
                                          child: Text(
                                            'گرانترین',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                                child: const Icon(
                                  Iconsax.sort,
                                  size: 24,
                                ),
                              ),
                              Text(
                                controller.selectedSort == null
                                    ? 'جدیدترین'
                                    : controller.selectedSort?.title ?? '',
                                style: context.theme.textTheme.bodySmall?.apply(
                                  color: context.theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'آگهی های جدید',
                          style: context.textTheme.titleLarge,
                        ),
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: () async {
                              if (controller.currentindex == 0) {
                                controller.getProvinces();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SelectCityDialogWidget();
                                  },
                                );
                              } else {
                                errorMessage('لطفا به صفحه خانه بروید');
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                const Icon(
                                  Iconsax.location,
                                  size: 24,
                                ),
                                Center(
                                  child: Text(
                                    controller.selectedCity?.name ??
                                        controller.selectedProvince?.name ??
                                        'کل کشور',
                                    style: context.theme.textTheme.bodySmall
                                        ?.apply(
                                      color: context.theme.colorScheme.primary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.adResponse == null
                    ? const Expanded(child: LoadingWidget())
                    : Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: <Widget>[
                            DashboardPage(
                              adModelList:
                                  controller.adResponse?.adModelList ?? [],
                            ),
                            const CategoriesPage(),
                            const SearchPage(),
                            const ProfilePage(),
                          ],
                        ),
                      ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            controller.items.length,
                            (index) => Padding(
                              padding: index == 1
                                  ? const EdgeInsets.only(
                                      left: 80,
                                    )
                                  : const EdgeInsets.all(0),
                              child: GestureDetector(
                                onTap: () {
                                  controller.changePage(index);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      controller.items[index].icon,
                                      color: controller.currentindex == index
                                          ? context.theme.primaryColor
                                          : const Color(0xff959595),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      controller.titleItems[index],
                                      style:
                                          context.textTheme.bodyMedium?.apply(
                                        color: controller.currentindex == index
                                            ? context.theme.primaryColor
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(const CreateAdsPage());
                        },
                        child: Container(
                          height: 47,
                          width: 47,
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Iconsax.add_square,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
