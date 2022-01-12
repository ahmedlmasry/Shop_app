import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/on%20boarding/on_boarding.dart';
import 'package:shop_app/shared/components/components.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasySplashScreen(
        logo: const Image(
          image: AssetImage('assets/images/shop_logo.jpg'),
        ),
        logoSize: 100,
        showLoader: false,
        title: const Text(
          'Salla Store',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        durationInSeconds: 3,
        navigator: OnBoardingScreen(),
      ),
    );
  }
}
