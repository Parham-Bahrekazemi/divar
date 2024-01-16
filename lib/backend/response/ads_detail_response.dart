import 'package:divar/backend/model/ads_detail_model.dart';

class AdsDetailResponse {
  AdsDetailModel? adsDetail;

  AdsDetailResponse({this.adsDetail});

  AdsDetailResponse.fromJson(Map<String, dynamic> json) {
    adsDetail =
        json['data'] != null ? AdsDetailModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (adsDetail != null) {
      data['data'] = adsDetail!.toJson();
    }
    return data;
  }
}
