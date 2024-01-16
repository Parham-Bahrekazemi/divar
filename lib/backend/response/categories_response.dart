import 'package:divar/backend/model/category_model.dart';

class CategoriesResponse {
  List<CategoryModel>? listCategory;

  CategoriesResponse({this.listCategory});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listCategory = <CategoryModel>[];
      json['data'].forEach((v) {
        listCategory!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listCategory != null) {
      data['data'] = listCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
