import 'package:suja_shoie_app/feature/presentaion/pages/widget/login_page_widget/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../responsive.dart';
import '../../../../../constant/utils/theme_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
        tablet: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            SizedBox(
                width: 200,
                child: Lottie.asset('assets/animations/142230-login.json')),
            const SizedBox(height: defaultPadding),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 450,
                  child: AuthScreen(),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
        desktop: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                      width: 200,
                      child:
                          Lottie.asset('assets/animations/142230-login.json')),
                  flex: 2,
                ),
                const Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        child: AuthScreen(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            SizedBox(
                width: 200,
                child: Lottie.asset('assets/animations/142230-login.json')),
            const Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: AuthScreen(),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          ],
        ),
      ),
    );
  }
}
