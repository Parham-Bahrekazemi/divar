import 'package:divar/backend/repository/home_repository.dart';
import 'package:divar/backend/response/ad_response.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  AdResponse? adResponse;

  bool loading = false;

  TextEditingController textSearchController = TextEditingController(text: '');

  void getAddByKeyWord() async {
    if (textSearchController.text.isNotEmpty) {
      loading = true;
      adResponse = null;

      update();

      adResponse =
          await homeRepository.getAds(keyword: textSearchController.text);
      loading = false;
      update();
    } else {
      errorMessage('لطفا متنی برای جستوجو وارد کنید');
    }
  }
}
