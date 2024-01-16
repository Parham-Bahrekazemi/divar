import 'package:dio/dio.dart';
import 'package:divar/helpers/user_helper.dart';
import 'package:get/get.dart';

class BaseRepsitory {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://divar.hitaldev.ir/api',
      validateStatus: (status) => status! < 500,
      headers: {
        'Accept': 'application/json',
        if (Get.isRegistered<UserHelper>())
          'Authorization': 'Bearer ${Get.find<UserHelper>().token}',
      },
    ),
  );
}
