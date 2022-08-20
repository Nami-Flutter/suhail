import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/shared/auth/create_new_password/cubit/cubit.dart';
import 'package:soheel_app/views/shared/auth/create_new_password/cubit/states.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../../constants.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/logo.dart';
import '../../../../widgets/text_form_field.dart';


class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPasswordCubit(),
      child: BlocBuilder<NewPasswordCubit,NewPasswordStates>(
        builder: (context, state) {
          final cubit = NewPasswordCubit.of(context);
          return Scaffold(
            // appBar: appBar(),
            body:Container(
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
                      child: Text('  كلمة المرور الجديدة ',style: getTextTheme.headline6!.copyWith(color: kPrimaryColor),),
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: Validator.password,
                      isNext: true,
                      secure: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: '  كلمه المرور',
                      onSave: (v)=> cubit.password = v,
                    ),
                    InputFormField(
                      fillColor: kWhiteColor,
                      validator: (v) => Validator.confirmPassword(v ?? '', cubit.password ?? ''),
                      isNext: true,
                      secure: true,
                      maxLength: 10,
                      verticalMargin: 10,
                      hint: 'تأكيد  كلمه المرور',
                      onSave: (v)=> cubit.confirm = v,
                    ),
                    state is NewPasswordLoadingState ? Loading() :
                    ConfirmButton(
                      title: '  تأكيد',
                      border: false,
                      verticalMargin: 10,
                      onPressed: cubit.newPassword,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ) ,
          );
        },
      ),
    );
  }
}
