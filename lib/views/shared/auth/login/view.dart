import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/shared/auth/forget_password/view.dart';
import 'package:soheel_app/views/shared/auth/login/cubit/cubit.dart';
import 'package:soheel_app/views/shared/auth/login/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/signup/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import '../../../../constants.dart';
import '../../../../core/validator/validation.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../../widgets/text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key, required this.isCaptain}) : super(key: key);
  final bool isCaptain;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => LoginCubit(isCaptain),
      child: Scaffold(
        // appBar: appBar(),
        body:BlocBuilder<LoginCubit,LoginStates>(
          builder: (context, state) {
            final cubit = LoginCubit.of(context);
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
                      child: Text(isCaptain ? 'تسجيل الدخول ' : 'تسجيل الدخول' ,style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.number,
                      onPressed: (){},
                      isNext: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: ' رقم الجوال 05xxxxxxxx ',
                      icon: FontAwesomeIcons.mobileAlt,
                      onSave: (v)=>cubit.telephone = v,
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.number,
                      onPressed: (){},
                      isNext: true,
                      secure: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: 'كلمة المرور  ',
                      icon: FontAwesomeIcons.unlockAlt,
                      onSave: (v)=>cubit.password = v,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                            onTap: (){
                              RouteManager.navigateTo(ForgetPasswordView());
                            },
                            child: Text('نسيت كلمت المرور ؟ ',style: getTextTheme.labelLarge!.copyWith(color: kBlueColor))),
                      ),),
                    BlocBuilder<LoginCubit,LoginStates>(
                      builder: (context, state) {
                       return state is LoginLoadingState ? Loading() :  ConfirmButton(
                            title: 'تسجيل الدخول',
                            border: false,
                            verticalMargin: 10,
                            color: kPrimaryColor,
                            onPressed:()=> cubit.login()
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' لا تمتلك حساب ؟ ',style: getTextTheme.titleMedium!.copyWith(color: kBlueColor),),
                          InkWell(
                            onTap: (){
                              isCaptain ?  RouteManager.navigateTo(SignUpView(isCaptain: true,)) :  RouteManager.navigateTo(SignUpView(isCaptain: false,));
                            },
                            child:Text(' انشاء حساب جديد',style: getTextTheme.titleMedium!.copyWith(color: kPrimaryColor),),
                          )
                        ],
                      ),
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
