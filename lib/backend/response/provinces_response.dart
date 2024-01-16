import 'package:divar/backend/model/provinces_model.dart';

class ProvincesResponse {
  List<ProvincesModel>? listProvinces;

  ProvincesResponse({this.listProvinces});

  ProvincesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listProvinces = <ProvincesModel>[];
      json['data'].forEach((v) {
        listProvinces!.add(ProvincesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listProvinces != null) {
      data['data'] = listProvinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
