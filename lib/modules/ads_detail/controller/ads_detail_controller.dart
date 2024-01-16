import 'package:divar/backend/repository/home_repository.dart';
import 'package:divar/backend/response/ads_detail_response.dart';
import 'package:get/get.dart';

class AdsDetailController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  AdsDetailResponse? adsDetailResponse;

  String adId;

  AdsDetailController(this.adId);

  void getDetailAd() async {
    adsDetailResponse = await homeRepository.getDetailAd(adId);
    update();
  }

  void bookmark(int adId) async {
    var response = await homeRepository.bookMark(adId);
  }

  @override
  void onInit() {
    getDetailAd();
    super.onInit();
  }
}
