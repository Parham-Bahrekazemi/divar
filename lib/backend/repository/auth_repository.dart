import 'package:divar/backend/repository/base_repository.dart';
import 'package:divar/backend/response/provinces_response.dart';
import 'package:divar/backend/response/register_response.dart';
import 'package:divar/helpers/widgets/snackbar_widget.dart';

class AuthRepository extends BaseRepsitory {
  Future<ProvincesResponse> getAllProvince() async {
    var response = await dio.get('/provinces');

    return ProvincesResponse.fromJson(response.data);
  }

  Future<RegisterResponse?> register({
    required String name,
    required String mobile,
    required String address,
    required int cityId,
    required String password,
    required String passwordConfirmation,
  }) async {
    var response = await dio.post(
      '/register',
      data: {
        'name': name,
        'mobile': mobile,
        'address': address,
        'city_id': cityId,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    print(response.data);

    if (response.statusCode == 200) {
      successMessage('ثبت نام با موفقیت انجام شد');
      return RegisterResponse.fromJson(response.data);
    } else {
      errorMessage('${response.data['message']}');
      return null;
    }
  }

  Future<RegisterResponse?> login({
    required String mobile,
    required String password,
  }) async {
    var response = await dio.post(
      '/login',
      data: {
        'mobile': mobile,
        'password': password,
      },
    );

    print(response.data);

    if (response.statusCode == 200) {
      successMessage('ورود با موفقیت انجام شد');
      return RegisterResponse.fromJson(response.data);
    } else {
      errorMessage('${response.data['message']}');
      return null;
    }
  }
}
