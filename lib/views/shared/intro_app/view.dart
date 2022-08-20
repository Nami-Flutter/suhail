import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soheel_app/views/shared/auth/login/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import '../../../../core/router/router.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../constants.dart';


class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);
  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Logo(heightFraction: 4)),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('اختار عضويتك',style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
            ),
            ConfirmButton(
              title: 'دخول التطبيق كعميل',
              border: false,
              verticalMargin: 10,
              onPressed: (){
                RouteManager.navigateTo(LoginView(isCaptain: false,));
              },
              color: kPrimaryColor,
            ),
            ConfirmButton(
              title: 'دخول التطبيق ككابتن',
              border: false,
              verticalMargin: 0,
              onPressed: (){
                RouteManager.navigateTo(LoginView(isCaptain: true,));
              },
              color: kAccentColor,
            ),
            SizedBox(height: 30,),
            Center(
              child: TextButton(
                  onPressed: (){
                    RouteManager.navigateTo(HomeView());
                  },
                  child: Text('الدخول كزائر',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryColor))),
            )
          ],
        ),
      ) ,
    );
  }
}
