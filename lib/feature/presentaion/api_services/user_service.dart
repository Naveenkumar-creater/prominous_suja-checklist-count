import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/data_source/remote/login_api_service.dart';
import 'package:suja_shoie_app/feature/data/repository/user_repository_imp.dart';
import 'package:suja_shoie_app/feature/domain/entity/userentity.dart';
import '../../data/core/api_client.dart';
import '../../data/model/usermodel.dart';
import '../../domain/repository/uers_repository.dart';
import '../../domain/usecase/user_usecase.dart';
import '../pages/home_page/main_screen.dart';
import '../pages/spalsh_screen.dart';
import '../providers/userprovider.dart';

class Login_auth_Screen {
// presentation/service/auth_service.dar
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      ApiClient apiClient = ApiClient(); // Create an instance of ApiClient
      ApiService apiService =
          ApiService(apiClient); // Pass the ApiClient instance to ApiService
      UserRepository userRepository = UserRepositoryImpl(
          apiService); // Create the UserRepository implementation
      SignInUserUseCase signInUserUseCase =
          SignInUserUseCase(userRepository); // Create the use case
      UserEntity user = await signInUserUseCase.execute(email, password);

      SharedPreferences pref = await SharedPreferences.getInstance();
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      await pref.setString("auth-token", user.token!);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
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
      await sharedPreferences.setString("auth-token", "");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      ApiClient apiClient = ApiClient(); // Create an instance of ApiClient
      ApiService apiService =
          ApiService(apiClient); // Pass the ApiClient instance to ApiService
      UserRepository userRepository = UserRepositoryImpl(
          apiService); // Create the UserRepository implementation
      GetUserDataUseCase getUserDataUseCase =
          GetUserDataUseCase(userRepository); // Create the use case

      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("auth-token");

      if (token == null) {
        pref.setString("auth-token", "");
      }

      UserEntity user = await getUserDataUseCase.execute(token!);

      var userProvid = Provider.of<UserProvider>(context, listen: false);
      userProvid.setUser(user);
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
