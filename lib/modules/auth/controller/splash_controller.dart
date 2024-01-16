import 'package:divar/helpers/user_helper.dart';
import 'package:divar/modules/auth/pages/splash_creen.dart';
import 'package:divar/modules/home/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  SharedPreferences? sharedPreferences;

  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void onInit() async {
    await initShared();

    Future.delayed(
      Duration.zero,
      () {
        if (sharedPreferences?.getString('token') != null) {
          Get.put<UserHelper>(
            UserHelper(
              sharedPreferences!.getString('token'),
            ),
          );
          Get.off(const HomePage());
        } else {
          Get.off(const SplashScreen());
        }
      },
    );
    super.onInit();
  }
}
