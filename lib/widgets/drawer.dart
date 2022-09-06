import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/edit_profile/view.dart';
import 'package:soheel_app/views/captain/wallet/view.dart';
import 'package:soheel_app/views/shared/about_app/view.dart';
import 'package:soheel_app/views/shared/contact_us/view.dart';
import 'package:soheel_app/views/shared/intro_app/view.dart';
import 'package:soheel_app/views/shared/notifications/view.dart';
import 'package:soheel_app/views/shared/splash/view.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/edit_profile/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../views/shared/terms_conditions/view.dart';
import 'my_text.dart';

drawer(){
  return Drawer(
    backgroundColor: kWhiteColor,
    child: Column(
      children: [
        AppStorage.customerGroup == 2 ?  DrawerHeader(
          decoration: BoxDecoration(
              color: kPrimaryColor
          ),
          child: Row(
            children: [
              Image.asset('assets/images/logo.png',width: sizeFromWidth(5),height: sizeFromHeight(3),),
              SizedBox(width: 20,),
              Text(AppStorage.getUserModel()!.firstname.toString(),style: TextStyle(fontSize: 24,color: kWhiteColor),)
            ],
          ),) :
        AppStorage.customerGroup == 1 ?  DrawerHeader(
          decoration: BoxDecoration(
              color: kPrimaryColor
          ),
          child: Row(
            children: [
              Image.asset('assets/images/logo.png',width: sizeFromWidth(5),height: sizeFromHeight(3),),
              SizedBox(width: 20,),
              Text(AppStorage.getUserModel()?.firstname.toString() ?? '',style: TextStyle(fontSize: 24,color: kWhiteColor),)
            ],
          ),) :
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png',height: sizeFromHeight(5),),
        ),
        Expanded(
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> AppStorage.customerGroup == 2 ? RouteManager.navigateTo(TripsView()) : RouteManager.navigateTo(HomeView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.home,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('الرئيسية',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                if (AppStorage.isLogged)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> RouteManager.navigateTo(TripsView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.truck,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('الرحلات',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                if (AppStorage.isLogged)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> AppStorage.customerGroup == 2 ? RouteManager.navigateTo((EditProfileCaptain())) : RouteManager.navigateTo(EditProfileView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.userAlt,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('الملف الشخصي',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                AppStorage.customerGroup == 2 ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=>RouteManager.navigateTo(WalletView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.wallet,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('المحفظة ',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ) : SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> RouteManager.navigateTo(AboutAppView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.info,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('حول التطبيق',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> RouteManager.navigateTo(TermsAndConditionsView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.fileAlt,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('الشروط و الأحكام',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: ()=> RouteManager.navigateTo(ContactUsView()),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.headset,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('الخط الساخن',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                if (AppStorage.isLogged && isDebugVersion)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: RouteManager.currentContext,
                        builder: (context) => CupertinoAlertDialog(
                          title: Column(
                            children: [
                              Icon(FontAwesomeIcons.userMinus, color: Colors.red.shade700, size: 50),
                              SizedBox(height: 20),
                              Text("حذف الحساب"),
                            ],
                          ),
                          actions: [
                            CupertinoButton(
                              child: MyText(
                                title: "تأكيد",
                                color: Colors.red.shade700,
                              ),
                              onPressed: () {
                                AppStorage.clearCache();
                                showSnackBar('تم حذف الحساب بنجاح!');
                                RouteManager.navigateAndPopAll(SplashView());
                              },
                            ),
                            CupertinoButton(
                              child: MyText(
                                title: "الغاء",
                                color: Colors.green.shade500,
                              ),
                              onPressed: RouteManager.pop,
                            ),
                          ],
                        ),
                        barrierDismissible: true,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.userMinus, color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text('حذف الحساب',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: InkWell(
                    onTap: (){
                      if (AppStorage.isLogged) {
                        AppStorage.clearCache();
                        RouteManager.navigateAndPopAll(SplashView());
                      } else {
                        RouteManager.navigateAndPopAll(IntroView());
                      }
                    },
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.signOutAlt,color: kPrimaryColor,size: 24,),
                        SizedBox(width: 10,),
                        Text(AppStorage.isLogged ? 'تسجيل الخروج' : 'تسجيل الدخول',style: TextStyle(fontSize: 18,color: kAccentColor),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}