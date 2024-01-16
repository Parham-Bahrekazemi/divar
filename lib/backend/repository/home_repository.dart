import 'package:divar/backend/repository/base_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/backend/response/ads_detail_response.dart';
import 'package:divar/backend/response/categories_response.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';

class HomeRepository extends BaseRepsitory {
  Future<AdResponse?> getAds({
    String? orderBy,
    String? orderType,
    String? provinceId,
    String? cityId,
    String? categoryId,
    String? keyword,
  }) async {
    var response = await dio.get(
      '/ad',
      queryParameters: {
        if (orderBy != null) 'order_by': orderBy,
        if (orderType != null) 'order_type': orderType,
        if (provinceId != null) 'province_id': provinceId,
        if (cityId != null) 'city_id': cityId,
        if (categoryId != null) 'category_id': categoryId,
        if (keyword != null) 'keyword': keyword,
      },
    );

    return AdResponse.fromJson(response.data);
  }

  Future<CategoriesResponse> getCategories() async {
    var response = await dio.get('/categories');

    return CategoriesResponse.fromJson(response.data);
  }

  Future<AdsDetailResponse> getDetailAd(String adId) async {
    var response = await dio.get('/ad/$adId');

    return AdsDetailResponse.fromJson(response.data);
  }

  Future<bool> bookMark(int adId) async {
    var response = await dio.post('/ad/$adId/bookmark');
    if (response.statusCode == 200) {
      successMessage(response.data['message']);
      return true;
    } else {
      return false;
    }
  }
}
