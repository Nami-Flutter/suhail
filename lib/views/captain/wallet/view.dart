import 'package:flutter/material.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/views/shared/trip_details/units/map.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'سهيل'
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('الرصيد المدين :',style: TextStyle(fontSize: 30,color: kPrimaryColor),),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1500-',style: TextStyle(color: kAccentColor,fontSize: 50),),
                SizedBox(width: 20,),
                Text('ريال',style: TextStyle(color: kAccentColor,fontSize: 20),),
              ],
            ),
            ConfirmButton(
              onPressed: (){},
              color: kAccentColor,
              title: 'دفع العموله عن طريق حساب بنكي',
            ),
            SizedBox(height: 15,),
            ConfirmButton(
              color: kAccentColor,
              onPressed: (){},
              title: 'دفع العموله عن طريق ماستر كارد  ',
            )
          ],
        ),
      ),
    );
  }
}
