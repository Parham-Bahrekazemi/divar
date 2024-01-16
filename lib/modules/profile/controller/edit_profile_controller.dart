import 'dart:io';

import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/backend/repository/auth_repository.dart';
import 'package:divar/backend/repository/profile_repository.dart';
import 'package:divar/backend/response/provinces_response.dart';
import 'package:divar/modules/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  ProvincesResponse? provincesResponse;

  AuthRepository repository = AuthRepository();

  ProvincesModel? selectedProvince;

  ProfileRepository profileRepository = ProfileRepository();

  CitiesModel? selectedCity;

  int cityId;

  String province;

  String name;

  TextEditingController textNameController = TextEditingController();

  TextEditingController textAddressController = TextEditingController();

  EditProfileController(this.province, this.cityId, this.name);

  File? file;

  GlobalKey<FormState> formKey = GlobalKey();

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا نام خود را وارد کنید';
    }
    return null;
  }

  void getAllProvinces() async {
    provincesResponse = await repository.getAllProvince();
    provincesResponse?.listProvinces?.forEach((element) {
      if (element.name == province) {
        selectedProvince = element;
        update();
      }
    });
    if (selectedProvince != null) {
      selectedProvince?.cities?.forEach((element) {
        if (element.id == cityId) {
          selectedCity = element;
          update();
        }
      });
    }
    textNameController.text = name;
    update();
  }

  void onSelectCity(CitiesModel citiesModel) {
    selectedCity = citiesModel;
    update();
  }

  void onSelectProvince(ProvincesModel province) {
    selectedProvince = province;
    update();
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      update();
    }
  }

  bool loading = false;

  Future<void> editProfile() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      update();
      var response = await profileRepository.editProfile(
        name: textNameController.text,
        cityId: selectedCity!.id.toString(),
        address: textAddressController.text.isEmpty
            ? null
            : textAddressController.text,
        avatar: file,
      );
      Get.find<ProfileController>().getProfile();
      loading = false;
      update();
    }
  }

  @override
  void onInit() {
    getAllProvinces();
    super.onInit();
  }
}
