import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/cubit.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/states.dart';
import 'package:soheel_app/views/captain/complete_register/vehicle_info.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/terms_conditions/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../constants.dart';
import '../../../core/router/router.dart';
import '../../../core/validator/validation.dart';
import '../../../widgets/confirm_button.dart';
import '../../../widgets/logo.dart';
import '../../../widgets/text_form_field.dart';
import '../../shared/auth/forget_password/view.dart';
import '../../shared/auth/signup/cubit/cubit.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CCompleteRegisterCubit.of(context);
    return Scaffold(
      // appBar: appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Form(
          key: cubit.personalInfoFormKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Logo(heightFraction: 4),
                ),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('استكمل البيانات ',style: getTextTheme.headline5!.copyWith(color: kPrimaryColor),),
              ),
              Text('  معلومات شخصية ',style: getTextTheme.subtitle1!.copyWith(color: kDarkGreyColor),),
              InputFormField(
                fillColor: kWhiteColor,
                validator: Validator.name,
                isNext: true,
                maxLength: 10,
                verticalMargin: 10,
                hint: '  الاسم الاول',
                controller: cubit.firstNameController,
              ),
              InputFormField(
                fillColor: kWhiteColor,
                validator: Validator.name,
                isNext: true,
                maxLength: 10,
                verticalMargin: 10,
                hint: '  الاسم الثاني',
                controller: cubit.lastNameController,
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kGreyColor,
                ),
                child: Center(child: Text(cubit.telephone.toString(),style: TextStyle(color: kDarkGreyColor,fontSize: 24),),),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Checkbox(value: true, onChanged: (_) {},
              //       checkColor: kWhiteColor,
              //       activeColor: kPrimaryColor,
              //     ),
              //     Text('انا اوفق على جميع'),
              //     TextButton(
              //       child: Text('الشروط والاحكام'),
              //       onPressed: ()=>RouteManager.navigateTo(TermsAndConditionsView()),
              //     )
              //   ],
              // ),
              BlocBuilder<CCompleteRegisterCubit,CCompleteRegisterStates>(
                builder: (context, state) {
                  return state is CCompleteRegisterLoadingStates ? Loading() : ConfirmButton(
                    title: 'التالي',
                    border: false,
                    verticalMargin: 10,
                    onPressed: (){
                      if (cubit.personalInfoFormKey.currentState?.validate() == true) {
                        final index = cubit.currentIndex + 1;
                        cubit.toggleView(index);
                      }
                    },
                    color: kPrimaryColor,
                  );

                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
