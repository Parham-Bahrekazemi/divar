import 'package:divar/backend/model/user_model.dart';

class RegisterResponse {
  UserModel? user;
  String? token;

  RegisterResponse({this.user, this.token});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
