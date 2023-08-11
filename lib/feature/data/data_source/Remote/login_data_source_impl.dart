import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suja_shoie_app/feature/data/core/login_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/login_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/loginmodel.dart';
import 'package:suja_shoie_app/feature/data/model/usermodel.dart';

import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';

class LoginDataSourceimpl extends LoginDataSource {
  final LoginClient loginClient;

  LoginDataSourceimpl(this.loginClient);

  @override
  @override
  Future<LoginModel> loginInUser(String loginId, String password) async {
    final response = await loginClient.post(loginId, password);

    final result = LoginModel.fromJson(response);
    print(result);

    return result;
  }
}
