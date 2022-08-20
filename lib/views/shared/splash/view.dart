import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import '../../../core/app_storage/app_storage.dart';
import '../intro_app/view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    checkNavigation();
    super.initState();
  }

  void checkNavigation() async {
    Timer(
      Duration(seconds: 4), () =>
    RouteManager.navigateAndPopAll(AppStorage.getUserModel() != null ? (AppStorage.customerGroup == 2) ? TripsView() : HomeView() : IntroView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash.png')
          )
        ),
        child: FadeInDownBig(
          delay: Duration(milliseconds: 300),
          child:Image.asset('assets/images/logo.png')
        ),
      ),
    );
  }
}
