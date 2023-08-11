import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suja_shoie_app/feature/data/core/api_client.dart';
import 'package:suja_shoie_app/feature/data/core/api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/api_service_base.dart';

import 'package:suja_shoie_app/feature/data/model/usermodel.dart';

import '../../core/api_constant.dart';

class ApiService extends ApiDataSource {
  final ApiClient apiclient;

  ApiService(this.apiclient);

  @override
  Future<UserModel> signInUser(String email, String password) async {
    final response = await apiclient.post('signin', email, password);
    final result = UserModel.fromJson(response);
    print(result);
    return result;
  }

  @override
  Future<UserModel> getUserData(String token) async {
    try {
      var tokenRes = await http.post(
        Uri.parse("${ApiConstant.baseUrl}tokenValidate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse("${ApiConstant.baseUrl}/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token,
          },
        );

        return UserModel.fromJson(jsonDecode(userRes.body));
      } else {
        throw Exception("Invalid token");
      }
    } catch (e) {
      throw e;
    }
  }
}
