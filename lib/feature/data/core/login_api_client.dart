import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/model/loginmodel.dart';
import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

import '../data_source/Remote/login_data_source_impl.dart';

class LoginClient {
  dynamic post(String loginId, String password) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
        apiFor: "generate_access_token",
        loginPassword: password,
        clGroup: "patienttype",
        loginId: loginId);
    try {
      http.Response response = await http.post(
        Uri.parse(ApiConstant.baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData.toJson()),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final responseMsg = responseJson['response_msg'];
        if (responseMsg != "Login access denied") {
          return responseJson;
        } else {
          throw (responseMsg); // Custom exception for access denied
        }
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      throw Exception("Failed to make the API request: $e");
    }
  }
}
