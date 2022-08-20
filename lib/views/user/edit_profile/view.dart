import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/shared/auth/create_new_password/view.dart';
import 'package:soheel_app/views/user/edit_profile/cubit/cubit.dart';
import 'package:soheel_app/views/user/edit_profile/cubit/states.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/drawer.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل',
          centerTitle: true,
        ),
        drawer: drawer(),
        body: BlocBuilder<EditProfileCubit,EditProfileStates>(
          builder: (context, state) {
            final cubit = EditProfileCubit.of(context);
            return state is EditProfileLoadingState ? Loading() :
             Form(
              key: cubit.formKey,
              child: ListView(
                children: [
                  Padding(padding:EdgeInsets.all(20),
                    child: Text('معلومات شخصية', style: TextStyle(fontSize: 18,color: kPrimaryColor),),
                  ),
                  // Center(
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           width: 100,
                  //           height: 100,
                  //           decoration: BoxDecoration(
                  //               color: kWhiteColor
                  //           ),
                  //           child: Icon(FontAwesomeIcons.camera,color: kPrimaryColor,),
                  //         ),
                  //         SizedBox(height: 10,),
                  //         Text('الصورة الشخصية',style: TextStyle(color: kDarkGreyColor),),
                  //         SizedBox(height: 20,),
                  //       ],
                  //     )
                  // ),
                  InputFormField(
                    hint: '  الاسم الاول',
                    fillColor: kWhiteColor,
                    horizontalMargin: 20,
                    verticalMargin: 5,
                    controller:cubit.firstNameController,
                    validator: Validator.name,
                    suffixIcon: Icon(FontAwesomeIcons.edit,color: kPrimaryColor,size: 16,),
                  ),
                  InputFormField(
                    hint: 'الاسم الاخير  ',
                    fillColor: kWhiteColor,
                    horizontalMargin: 20,
                    verticalMargin: 5,
                    controller: cubit.lastNameController,
                    validator: Validator.name,
                    suffixIcon: Icon(FontAwesomeIcons.edit,color: kPrimaryColor,size: 16,),
                  ),
                  InputFormField(
                    hint: 'رقم الجوال  ',
                    fillColor: kWhiteColor,
                    horizontalMargin: 20,
                    verticalMargin: 5,
                    controller: cubit.telephoneController,
                    validator: Validator.phoneNumber,
                    disabled: true,
                  ),
                  // InputFormField(
                  //   hint: '  كلمه المرور',
                  //   fillColor: kWhiteColor,
                  //   horizontalMargin: 20,
                  //   verticalMargin: 5,
                  //   validator: Validator.password,
                  //   secure: true,
                  //   controller: cubit.passwordController,
                  //   suffixIcon: Icon(FontAwesomeIcons.edit,color: kPrimaryColor,size: 16,),
                  // ),
                  SizedBox(height: 50,),
                  BlocBuilder<EditProfileCubit,EditProfileStates>(
                    builder: (context, state) {
                     return state is EditProfileLoadingState ? Loading() : ConfirmButton(
                        verticalMargin: 20,
                        onPressed: cubit.editProfile,
                        horizontalMargin: 20,
                        title: '  تعديل',
                        color: kPrimaryColor,
                      );
                    },
                  ),
                  ConfirmButton(
                    verticalMargin: 10,
                    horizontalMargin: 20,
                    color: kPrimaryColor,
                    title: 'تغيير كلمة المرور',
                    onPressed:()=> RouteManager.navigateTo(CreateNewPasswordView()),
                  )

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
