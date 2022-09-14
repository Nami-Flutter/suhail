import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soheel_app/views/shared/splash/view.dart';
import 'package:soheel_app/widgets/pop_scaffold.dart';
import 'constants.dart';
import 'core/app_storage/app_storage.dart';
import 'core/dio_manager/dio_manager.dart';
import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await AppStorage.init();
  getVersionStatus();
  getUserAndCache(320, 1);
  // getUserAndCache(323, 2);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'سهيل',
      builder: (context, child) => PopScaffold(child: child!),
      home: SplashView()
    );
  }
}

