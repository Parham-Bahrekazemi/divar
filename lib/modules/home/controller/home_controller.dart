import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/backend/repository/auth_repository.dart';
import 'package:divar/backend/repository/home_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/backend/response/provinces_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends GetxController {
  List<MenuItem> items = [
    MenuItem(icon: Iconsax.home_2),
    MenuItem(icon: Iconsax.category),
    MenuItem(icon: Iconsax.search_normal),
    MenuItem(icon: Iconsax.user),
  ];

  List<String> titleItems = <String>[
    'خانه',
    'دسته بندی',
    'جستجو',
    'پروفایل',
  ];

  PageController pageController = PageController(initialPage: 0);

  void changePage(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

    currentindex = page;
    update();
  }

  int currentindex = 0;

  SortProduct? selectedSort;

  AdResponse? adResponse;

  HomeRepository homeRepository = HomeRepository();

  void getAds() async {
    adResponse = await homeRepository.getAds(
      orderBy: selectedSort?.orderC,
      orderType: selectedSort?.orderT,
      provinceId: selectedProvince?.id.toString(),
      cityId: selectedCity?.id.toString(),
    );

    update();
  }

  void sortAd(SortProduct value) {
    selectedSort = value;
    adResponse = null;
    update();
    getAds();
  }

  @override
  void onInit() {
    getAds();
    super.onInit();
  }

  //location

  ProvincesModel? selectedProvince;
  CitiesModel? selectedCity;

  AuthRepository authRepository = AuthRepository();

  ProvincesResponse? provincesResponse;

  void getProvinces() async {
    provincesResponse = await authRepository.getAllProvince();
    update();
  }

  void sortByLocation({
    ProvincesModel? province,
    CitiesModel? city,
  }) async {
    selectedProvince = province;
    selectedCity = city;
    adResponse = null;
    update();
    getAds();
    update();
  }
}

class MenuItem {
  IconData icon;

  bool selected;

  MenuItem({required this.icon, this.selected = false});
}

class SortProduct {
  String? orderC;
  String? orderT;
  String? title;

  SortProduct({
    required this.orderC,
    required this.orderT,
    required this.title,
  });
}
