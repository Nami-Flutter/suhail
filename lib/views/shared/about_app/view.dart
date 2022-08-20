import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soheel_app/constants.dart';

import '../../../widgets/app_bar.dart';
import '../../../widgets/drawer.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({Key? key}) : super(key: key);

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
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Center(child: Image.asset('assets/images/logo.png',width: sizeFromWidth(2),),),
                     SizedBox(height: 20,),
                     Text('حول التطبيق',style: TextStyle(color: kPrimaryColor,fontSize: 24),),
                   ],
                ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(' هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة ',
                    style: TextStyle(color: kDarkGreyColor,fontSize: 16),),
                ),
              ],
            )
          ),



        ],
      ),
    );
  }
}
