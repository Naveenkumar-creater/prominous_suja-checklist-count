import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:suja_shoie_app/feature/data/core/login_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/login_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/login_repository_imp.dart';
import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';
import 'package:suja_shoie_app/feature/presentaion/pages/spalsh_screen.dart';
import 'package:suja_shoie_app/feature/presentaion/providers/loginprovider.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/usecase/login_usecase.dart';
import '../pages/home_page/main_screen.dart';

class LoginApiService {
  void login({
    required BuildContext context,
    required String loginId,
    required String password,
  }) async {
    try {
      LoginClient apiClient = LoginClient();
      LoginDataSourceimpl loginData =
          LoginDataSourceimpl(apiClient); // Use the LoginDataSourceimpl
      LoginRepository loginRepository = LoginRepositoryImpl(loginData);
      LoginUseCase loginUseCase = LoginUseCase(loginRepository);

      loginEntity loginUser = await loginUseCase.execute(loginId, password);

      print(loginUser);

      SharedPreferences pref = await SharedPreferences.getInstance();

      Provider.of<LoginProvider>(context, listen: false).setUser(loginUser);

      await pref.setString("client_token", loginUser.clientauthToken!);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOutUSer(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("client_token", "");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

void showSnackBar(BuildContext? context, String message) {
  if (context != null) {
    final snackBar = SnackBar(
      backgroundColor: Colors.amber[400],
      content:
          Center(child: Text(message, style: TextStyle(color: Colors.black))),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
