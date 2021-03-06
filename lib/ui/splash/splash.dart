import 'dart:async';

import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: AppIconWidget(image: 'assets/icons/ic_appicon.png')),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(Preferences.is_onBoarding) != true) {
      preferences.setBool(Preferences.is_onBoarding, true);
      Navigator.of(context).pushReplacementNamed(Routes.onBoardingMain);
      preferences.setBool(Preferences.is_splash, true);
    } else {
      if (preferences.getBool(Preferences.is_logged_in) != true) {
        Navigator.of(context).pushReplacementNamed(Routes.login);
        preferences.setBool(Preferences.is_splash, true);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
        preferences.setBool(Preferences.is_splash, true);
      }
    }
  }
}
