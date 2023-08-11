import 'package:flutter/material.dart';

import 'widget/login_page_widget/responsive_login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8,
          ),
          children: const [LoginScreen()],
        ),
      ),
    );
  }
}
