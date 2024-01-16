import 'dart:io';

import 'package:divar/backend/model/category_model.dart';
import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/backend/repository/ads_repository.dart';
import 'package:divar/backend/repository/auth_repository.dart';
import 'package:divar/backend/repository/home_repository.dart';
import 'package:divar/backend/response/categories_response.dart';
import 'package:divar/backend/response/provinces_response.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/modules/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateAdsController extends GetxController {
  ProvincesResponse? provincesResponse;

  AuthRepository repository = AuthRepository();

  ProvincesModel? selectedProvince;

  CitiesModel? selectedCity;

  void getAllProvinces() async {
    provincesResponse = await repository.getAllProvince();
    update();
  }

  void onSelectProvince(ProvincesModel value) {
    selectedProvince = value;
    selectedCity = null;
    update();
  }

  void onSelectCity(CitiesModel value) {
    selectedCity = value;
    update();
  }

  //////////////////////////////////////////////////////////////////////////////
  CategoriesResponse? categoriesResponse;

  HomeRepository homeRepository = HomeRepository();

  CategoryModel? selectedCategory;

  void getCategories() async {
    categoriesResponse = await homeRepository.getCategories();
    update();
  }

  void onSelectCategory(CategoryModel category) {
    selectedCategory = category;
    txtCategoryController.text = selectedCategory?.name ?? '';
    update();
  }

  //////////////////////////////////////////////////////////////////////////////////////

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController txtTitleAdController = TextEditingController();
  TextEditingController txtCategoryController = TextEditingController();
  TextEditingController txtDescriptionController = TextEditingController();
  TextEditingController txtPriceController = TextEditingController();
  TextEditingController txtImageController = TextEditingController();

  File? file;

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      txtImageController.text = 'عکس انتخاب شد';
      update();
    }
  }

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا عنوان آگهی را وارد کنید';
    }
    return null;
  }

  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا توضیحات آگهی را وارد کنید';
    }
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا قیمت آگهی را وارد کنید';
    }
    return null;
  }

  AdRepository adRepository = AdRepository();

  bool loading = false;

  void createAds() async {
    if (formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        errorMessage('لطفا دسته بندی آگهی را انتخاب کنید');
      } else if (file == null) {
        errorMessage('لطفا عکس آگهی را انتخاب کنید');
      } else if (selectedCity == null) {
        errorMessage('لطفا شهر را انتخاب کنید');
      } else {
        loading = true;
        update();
        bool response = await adRepository.createAds(
          title: txtTitleAdController.text,
          categoryId: selectedCategory!.id.toString(),
          cityId: selectedCity!.id.toString(),
          price: txtPriceController.text,
          description: txtDescriptionController.text,
          image: file!,
        );
        if (response) {
          txtTitleAdController.clear();
          selectedCategory = null;
          selectedCity = null;
          selectedProvince = null;
          txtPriceController.clear();
          txtDescriptionController.clear();
          txtCategoryController.clear();
          txtImageController.clear();
          file = null;
          loading = false;
          update();

          Get.find<HomeController>().getAds();
        }
        loading = false;
        update();
      }
    }
  }

  @override
  void onInit() {
    getAllProvinces();
    getCategories();
    super.onInit();
  }
}
