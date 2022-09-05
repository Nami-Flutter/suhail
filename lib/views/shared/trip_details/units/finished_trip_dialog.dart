import 'package:flutter/material.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

Future showFinishedTripDialog(BuildContext context, {required }){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('تم انهاء الرحلة',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('عدد الكيلومتر',style: TextStyle(fontWeight: FontWeight.w700),),
                  Text('187 Km',style: TextStyle(fontWeight: FontWeight.w700,color: kPrimaryColor,fontSize: 20)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المبلغ',style: TextStyle(fontWeight: FontWeight.w700),),
                  Text('150 ريال',style: TextStyle(fontWeight: FontWeight.w700,color: kPrimaryColor,fontSize: 20)),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                return ConfirmButton(
                  title: ' متابعة ',
                  onPressed: (){
                    RouteManager.navigateAndPopAll(TripsView());
                  },
                );
              },
            )
          ],
        ),
      ));
}
