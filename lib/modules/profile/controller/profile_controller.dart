import 'package:divar/backend/model/user_model.dart';
import 'package:divar/backend/repository/profile_repository.dart';
import 'package:divar/modules/auth/pages/splash_creen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  ProfileRepository profileRepository = ProfileRepository();

  UserModel? userModel;

  void getProfile() async {
    userModel = await profileRepository.getProfile();
    update();
  }

  SharedPreferences? sharedPreferences;

  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void logout() {
    sharedPreferences!.remove('token');
    Get.offAll(const SplashScreen());
  }

  @override
  void onInit() {
    initShared();
    getProfile();
    super.onInit();
  }
}
