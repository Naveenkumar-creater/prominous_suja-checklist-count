import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

import 'package:suja_shoie_app/feature/presentaion/pages/login_page.dart';

import '../../../constant/utils/font_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset(
                'assets/animations/94350-gears-lottie-animation.json',
                controller: _controller,
                onLoaded: (p0) {
                  _controller
                    ..duration = const Duration(milliseconds: 1000)
                    ..forward().then((value) => Navigator.push(
                        context,
                        PageTransition(
                            child: const LoginPage(),
                            type: PageTransitionType.bottomToTop)));
                },
              ),
            ),
            const Headings(
              subHeading: 'Suja Shoei',
              heading: '',
            )
          ],
        ),
      ),
    );
  }
}
