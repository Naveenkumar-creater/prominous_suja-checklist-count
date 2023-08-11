import '../../domain/repository/uers_repository.dart';

import '../data_source/remote/login_api_service.dart';

import '../model/usermodel.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<UserModel> signInUser(String email, String password) async {
    UserModel userModel = await apiService.signInUser(email, password);
    return userModel;
  }

  @override
  Future<UserModel> getUserData(String token) async {
    UserModel userModel = (await apiService.getUserData(token)) as UserModel;
    return userModel;
  }
}
