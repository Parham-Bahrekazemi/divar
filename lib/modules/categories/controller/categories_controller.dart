import 'package:divar/backend/repository/home_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/backend/response/categories_response.dart';
import 'package:get/get.dart';

class CategortController extends GetxController {
  CategoriesResponse? categoriesResponse;

  HomeRepository homeRepository = HomeRepository();

  void getCategories() async {
    categoriesResponse = await homeRepository.getCategories();
    update();
  }

  AdResponse? adResponse;

  void getAdsByCategory(String categoryId) async {
    adResponse = await homeRepository.getAds(
      categoryId: categoryId,
    );
    update();
    print(adResponse?.adModelList?.length);
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
