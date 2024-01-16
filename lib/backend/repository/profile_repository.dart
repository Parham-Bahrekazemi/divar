import 'dart:io';

import 'package:dio/dio.dart';
import 'package:divar/backend/model/user_model.dart';
import 'package:divar/backend/repository/base_repository.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';

import 'package:path/path.dart';

class ProfileRepository extends BaseRepsitory {
  Future<UserModel> getProfile() async {
    var response = await dio.get('/profile');

    return UserModel.fromJson(response.data['data']);
  }

  Future<void> editProfile({
    required String name,
    required String cityId,
    String? address,
    File? avatar,
  }) async {
    MultipartFile? file;

    if (avatar != null) {
      String filename = basename(avatar.path);
      file = await MultipartFile.fromFile(
        avatar.path,
        filename: filename,
        // contentType: MediaType(
        //     'image', 'jpeg'), // Adjust the content type as per your requirements
      );
    }

    FormData formData = FormData.fromMap({
      'name': name,
      'city_id': cityId,
      if (address != null) 'address': address,
      if (avatar != null) 'avatar': file,
    });
    var response = await dio.post(
      '/profile',
      data: formData,
    );

    if (response.statusCode == 200) {
      successMessage(response.data['message']);
    } else {
      errorMessage('اطلاعات ویرایش نشد');
    }
  }
}
