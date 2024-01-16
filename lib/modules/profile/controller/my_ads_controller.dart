import 'package:divar/backend/repository/ads_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class MyAdsController extends GetxController {
  AdRepository adRepository = AdRepository();
  AdResponse? adResponse;

  void getMyAds() async {
    adResponse = await adRepository.getMyAds();
    update();
  }

  void deleteAd(int adId) async {
    adResponse?.adModelList?.removeWhere((element) => element.id == adId);
    update();
    var response = await adRepository.deleteAd(adId);

    if (response) {
      Get.find<HomeController>().getAds();
    }
  }

  @override
  void onInit() {
    getMyAds();
    super.onInit();
  }
}
