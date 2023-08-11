import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/api_service_base.dart';
import 'package:suja_shoie_app/feature/data/model/usermodel.dart';

class ApiClient {
  dynamic post(String path, String email, String password) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${ApiConstant.baseUrl}/$path'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      throw e;
    }
  }
}
