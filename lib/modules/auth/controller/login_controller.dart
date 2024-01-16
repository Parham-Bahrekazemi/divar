import 'package:divar/backend/repository/auth_repository.dart';
import 'package:divar/backend/response/register_response.dart';
import 'package:divar/helpers/user_helper.dart';
import 'package:divar/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? mobileValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا شماره موبایل خود را وارد کنید';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا رمز عبور خود را وارد کنید';
    }

    return null;
  }

  AuthRepository authRepository = AuthRepository();

  SharedPreferences? sharedPreferences;

  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool loading = false;

  TextEditingController textNumberController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  void login() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      update();
      RegisterResponse? response = await authRepository.login(
        mobile: textNumberController.text,
        password: textPasswordController.text,
      );
      if (response != null) {
        sharedPreferences!.setString('token', response.token!);
        Get.put<UserHelper>(
          UserHelper(
            sharedPreferences!.getString('token'),
          ),
        );

        print('token : ${sharedPreferences!.getString('token')}');
        Get.to(const HomePage());
      }
      loading = false;
      update();
    }
  }

  @override
  void onInit() {
    initShared();
    super.onInit();
  }
}
