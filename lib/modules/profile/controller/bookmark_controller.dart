import 'package:divar/backend/repository/ads_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:get/get.dart';

class BookMarkController extends GetxController {
  AdRepository adRepository = AdRepository();
  AdResponse? adResponse;

  void getBookmarkAds() async {
    adResponse = await adRepository.getBookmarkAds();
    update();
  }

  void deleteBookMark(int adId) async {
    adResponse?.adModelList?.removeWhere((element) => element.id == adId);
    update();
    var response = await adRepository.deleteBookMark(adId);
  }

  @override
  void onInit() {
    getBookmarkAds();
    super.onInit();
  }
}
