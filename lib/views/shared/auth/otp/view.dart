import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/views/shared/auth/otp/cubit/cubit.dart';
import 'package:soheel_app/views/shared/auth/otp/cubit/states.dart';

import '../../../../constants.dart';
import '../../../../core/validator/validation.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../../widgets/pin_code_field.dart';
import '../../../../widgets/text_form_field.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key, required this.telephone, required this.customerId, required this.completeRegister, required this.isCaptain}) : super(key: key);
  final String telephone;
  final int customerId;
  final bool completeRegister;
  final bool isCaptain;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        telephone: telephone,
        customerId: customerId,
        completeRegister: completeRegister,
        isCaptain: isCaptain,
      ),
      child: Scaffold(
        // appBar: appBar(),
        body:BlocBuilder<OtpCubit,OtpStates>(
          builder: (context, state) {
            final cubit = OtpCubit.of(context);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Form(
                key: cubit.formKey,
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
                      child: Text('التأكيد على الجوال  ',style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('تم ارسال رمز التأكيد على الجوال تأكد من ادخال الرقم الصحيح',
                        style: getTextTheme.headline6!.copyWith(color: kBlueColor),),
                    ),
                    PinCodeField(
                      onChanged: (v)=> cubit.code = v
                    ),
                    ConfirmButton(
                      title: '  تأكيد الرمز',
                      border: false,
                      verticalMargin: 0,
                      color: kPrimaryColor,
                        onPressed: cubit.activate
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' لم تستلم رسالة ؟  ',style: getTextTheme.titleMedium!.copyWith(color: kBlueColor),),
                          InkWell(
                            onTap: (){
                              cubit.resendCode();
                            },
                            child:Text('أعد الارسال ',style: getTextTheme.titleMedium!.copyWith(color: kPrimaryColor),),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(telephone,style: Theme.of(context).textTheme.headline5?.copyWith(color: kPrimaryColor),),
                        SizedBox(width: 20,),
                        Icon(FontAwesomeIcons.mobileAlt,color: kBlueColor,),

                      ],
                    )

                  ],
                ),
              ),
            );
          },
        ) ,
      ),
    );
  }
}
