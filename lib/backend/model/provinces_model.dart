class ProvincesModel {
  int? id;
  String? name;
  List<CitiesModel>? cities;

  ProvincesModel({this.id, this.name, this.cities});

  ProvincesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['cities'] != null) {
      cities = <CitiesModel>[];
      json['cities'].forEach((v) {
        cities!.add(CitiesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CitiesModel {
  int? id;
  String? name;
  int? provinceId;

  CitiesModel({this.id, this.name, this.provinceId});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['province_id'] = provinceId;
    return data;
  }
}
