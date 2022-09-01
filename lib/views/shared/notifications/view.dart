import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/drawer.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'سهيل',
        centerTitle: true,
      ),
      drawer: drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(20),
          child: Text('أحدث التنبيهات : ',style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor),),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhiteColor
                  ),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.bell,size: 26,color: kPrimaryColor,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تم الغاء الرحلة',style: Theme.of(context).textTheme.headline6,),
                          Text('ديزل',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhiteColor
                  ),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.bell,size: 26,color: kPrimaryColor,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تم الغاء الرحلة',style: Theme.of(context).textTheme.headline6,),
                          Text('ديزل',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhiteColor
                  ),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.bell,size: 26,color: kPrimaryColor,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تم الغاء الرحلة',style: Theme.of(context).textTheme.headline6,),
                          Text('ديزل',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhiteColor
                  ),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.bell,size: 26,color: kPrimaryColor,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('تم الغاء الرحلة',style: Theme.of(context).textTheme.headline6,),
                          Text('ديزل',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
