import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/presentaion/api_services/user_service.dart';

import '../../../../../constant/utils/custom_button.dart';
import '../../../api_services/login_api .dart';
// import '../services/auth_services.dart';

class AuthScreen extends StatefulWidget {
  static const String routName = "/auth_screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  // final Login_auth_Screen authScreen = Login_auth_Screen();
  final LoginApiService loginApiService = LoginApiService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // void signInUser() {
  //   (authScreen.signInUser(
  //     context: context,
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //   ));
  // }

  void logInUser() {
    (loginApiService.login(
      context: context,
      loginId: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signinFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email or phone number';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter email or Phone number',
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _passwordController,
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.black45),
              counterText: 'Forgot password?',
              counterStyle: TextStyle(color: Colors.black38),
              suffixIcon: const Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: "Sign In",
            onTap: () {
              if (signinFormKey.currentState?.validate() == true) {
                // signInUser();

                logInUser();
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const MainScreen(),
              //     ));
            },
          )
        ],
      ),
    );
  }
}
