import 'package:divar/backend/model/ad_model.dart';

class AdResponse {
  List<AdModel>? adModelList;

  AdResponse({this.adModelList});

  AdResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      adModelList = <AdModel>[];
      json['data'].forEach((v) {
        adModelList!.add(AdModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (adModelList != null) {
      data['data'] = adModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
