import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';

import '../../../../constants.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../../widgets/text_form_field.dart';


class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Logo(heightFraction: 4),
              ),),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('  كلمة المرور الجديدة ',style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
            ),
            InputFormField(
              fillColor: kWhiteColor,
              validator: Validator.password,
              onPressed: (){},
              isNext: true,
              secure: true,
              maxLength: 10,
              verticalMargin: 10,
              hint: '  كلمه المرور',
            ),
            InputFormField(
              fillColor: kWhiteColor,
              validator: Validator.password,
              onPressed: (){},
              isNext: true,
              secure: true,
              maxLength: 10,
              verticalMargin: 10,
              hint: 'تأكيد  كلمه المرور',
            ),
            ConfirmButton(
              title: '  تأكيد',
              border: false,
              verticalMargin: 10,
              onPressed: (){
              },
              color: kPrimaryColor,
            ),
          ],
        ),
      ) ,
    );
  }
}
