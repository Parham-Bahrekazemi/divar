import 'package:divar/backend/model/provinces_model.dart';
import 'package:divar/backend/repository/auth_repository.dart';
import 'package:divar/backend/response/provinces_response.dart';
import 'package:divar/backend/response/register_response.dart';
import 'package:divar/helpers/user_helper.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:divar/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

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

  @override
  void onInit() {
    initShared();
    getAllProvinces();
    super.onInit();
  }

  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtMobileController = TextEditingController();
  TextEditingController txtAddressController = TextEditingController();
  TextEditingController txtPassworController = TextEditingController();
  TextEditingController txtPasswordConfirmationController =
      TextEditingController();

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا نام خود را وارد کنید';
    }
    return null;
  }

  String? mobileValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا شماره موبایل خود را وارد کنید';
    }
    if (value.length < 11 || value.length > 11) {
      return 'شماره موبایل باید یازده رقم باشد';
    }
    if (!RegExp(r'^09[0|1|2|3][0-9]{8}$').hasMatch(value)) {
      return 'لطفا شماره موبایل معتبر وارد کنید';
    }
    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا آدرس خود را وارد کنید';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا رمز عبور خود را وارد کنید';
    }
    if (value.length < 8) {
      return 'رمز عبور باید بیشتر از هشت رقم باشد';
    }

    return null;
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا تکرار رمز عبور خود را وارد کنید';
    }
    if (value != txtPassworController.text) {
      return 'رمز عبور و تکرار رمز عبور باید  یکسان باشد';
    }

    return null;
  }

  bool loading = false;

  SharedPreferences? sharedPreferences;

  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void register() async {
    if (fromKey.currentState!.validate()) {
      if (selectedCity != null) {
        loading = true;
        update();

        RegisterResponse? registerResponse = await repository.register(
          name: txtNameController.text,
          mobile: txtMobileController.text,
          address: txtAddressController.text,
          cityId: selectedCity!.id!,
          password: txtPassworController.text,
          passwordConfirmation: txtPasswordConfirmationController.text,
        );

        if (registerResponse != null) {
          sharedPreferences!.setString('token', registerResponse.token!);

          Get.put<UserHelper>(
            UserHelper(
              sharedPreferences!.getString('token'),
            ),
          );

          Get.to(const HomePage());
        }

        loading = false;
        update();
      } else {
        errorMessage('لطفا شهر خود را انتخاب کنید');
      }
    }
  }
}
