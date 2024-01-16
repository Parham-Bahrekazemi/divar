import 'dart:io';

import 'package:divar/backend/repository/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:path/path.dart';

class AdRepository extends BaseRepsitory {
  Future<bool> createAds({
    required String title,
    required String categoryId,
    required String cityId,
    required String price,
    required String description,
    required File image,
  }) async {
    MultipartFile? file;

    String filename = basename(image.path);
    file = await MultipartFile.fromFile(
      image.path,
      filename: filename,
      // contentType: MediaType(
      //     'image', 'jpeg'), // Adjust the content type as per your requirements
    );

    FormData formData = FormData.fromMap({
      'title': title,
      'category_id': categoryId,
      'city_id': cityId,
      'price': price,
      'description': description,
      'image': file,
    });

    var response = await dio.post('/ad', data: formData);

    if (response.statusCode == 200) {
      successMessage(response.data['message']);
      return true;
    } else {
      errorMessage(response.data['message']);
      print(response.data);
      return true;
    }
  }

  Future<AdResponse> getMyAds() async {
    var response = await dio.get('/user/ads');

    return AdResponse.fromJson(response.data);
  }

  Future<bool> deleteAd(int adId) async {
    var response = await dio.delete('/ad/$adId');

    if (response.statusCode == 200) {
      successMessage(response.data['message']);
      return true;
    } else {
      errorMessage(response.data['message']);
      return false;
    }
  }

  Future<AdResponse> getBookmarkAds() async {
    var response = await dio.get('/bookmarks');

    return AdResponse.fromJson(response.data);
  }

  Future<bool> deleteBookMark(int adId) async {
    var response = await dio.post('/ad/$adId/bookmark');
    if (response.statusCode == 200) {
      successMessage(response.data['message']);
      return true;
    } else {
      return false;
    }
  }
}
