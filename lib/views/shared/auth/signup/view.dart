import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/captain/complete_register/personal_info.dart';
import 'package:soheel_app/views/shared/about_app/view.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/cubit.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/terms_conditions/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import '../../../../constants.dart';
import '../../../../core/validator/validation.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../../widgets/text_form_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key, required this.isCaptain}) : super(key: key);
  final bool isCaptain;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(isCaptain),
      child: Scaffold(
        // appBar: appBar(),
        body:BlocBuilder<SignUpCubit,SignUpStates>(
          builder: (context, state) {
            final cubit = SignUpCubit.of(context);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Logo(heightFraction: 4),
                      ),),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(isCaptain ? ' انشاء حساب جديد' : ' انشاء حساب جديد',style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
                    ),
                    isCaptain ? SizedBox() :
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.name,
                      onPressed: (){},
                      isNext: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: 'الاسم الاول',
                      onSave: (e)=> cubit.firstname = e,
                    ),
                    isCaptain ? SizedBox() :
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.name,
                      onPressed: (){},
                      isNext: true,
                      verticalMargin: 10,
                      hint: 'الاسم الاخير',
                      onSave: (e)=> cubit.lastname = e,
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.phoneNumber,
                      isNext: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: ' رقم الجوال 05xxxxxxxx ',
                      onSave: (e)=> cubit.telephone = e,
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.password,
                      isNext: true,
                      secure: true,
                      verticalMargin: 10,
                      hint: '  كلمة المرور',
                      onSave: (e)=> cubit.password = e,
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: (v) => Validator.confirmPassword(v ?? '', cubit.password ?? ''),
                      onPressed: (){},
                      isNext: true,
                      secure: true,
                      verticalMargin: 10,
                      hint: 'تأكيد  كلمة المرور',
                      onSave: (e)=> cubit.confirm = e,
                    ),

                    BlocBuilder<SignUpCubit,SignUpStates>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(value: cubit.agreedToTerms, onChanged: cubit.toggleAgreedToTerms,
                                  checkColor: kWhiteColor,
                                  activeColor: kPrimaryColor,
                                ),
                                Text('انا اوفق على جميع'),
                                InkWell(
                                    onTap: ()=> RouteManager.navigateTo(TermsAndConditionsView()),
                                    child: Text(' الشروط و الأحكام ', style: TextStyle(color: kPrimaryColor), ))
                              ],
                            ),
                            state is SignUpLoadingState ? Loading(vMargin: 10) : ConfirmButton(
                              title: '  انشاء حساب جديد',
                              border: false,
                              verticalMargin: 10,
                              color: kPrimaryColor,
                              onPressed: cubit.agreedToTerms ? cubit.signUp : null,
                            ),
                          ],
                        );
                      },
                    ),
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
