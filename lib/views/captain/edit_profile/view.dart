import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/captain/edit_profile/cubit/cubit.dart';
import 'package:soheel_app/views/captain/edit_profile/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/create_new_password/view.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

import '../../../constants.dart';
import '../../../widgets/drawer.dart';

class EditProfileCaptain extends StatefulWidget {
  const EditProfileCaptain({Key? key}) : super(key: key);

  @override
  _EditProfileCaptainState createState() => _EditProfileCaptainState();
}

class _EditProfileCaptainState extends State<EditProfileCaptain> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCaptainCubit()..editProfileCaptain(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل',
          centerTitle: true,
        ),
        drawer: drawer(),
        body:Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
          child: BlocBuilder<EditProfileCaptainCubit , EditProfileCaptainStates>(
            builder: (context, state) {
              final cubit = EditProfileCaptainCubit.of(context);
              final vehicleData = cubit.captainInfoModel?.captainInfo;
              return  ListView(
                children: [
                  InputFormField(
                    hint: '  الاسم الاول',
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    controller:cubit.firstNameController,
                    validator: Validator.name,
                    suffixIcon: Icon(FontAwesomeIcons.edit,color: kPrimaryColor,size: 16,),
                  ),
                  InputFormField(
                    hint: '  الاسم الأخير',
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    controller:cubit.lastNameController,
                    validator: Validator.name,
                    suffixIcon: Icon(FontAwesomeIcons.edit,color: kPrimaryColor,size: 16,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text('معلومات المركبة',style: TextStyle(fontSize: 20,color: kPrimaryColor),),
                  ),
                  InputFormField(
                    hint: cubit.captainInfoModel?.captainInfo![0].categoryName.toString(),
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    // controller:cubit.vehicleType,
                    disabled: true,
                    validator: Validator.name,
                  ),
                  InputFormField(
                    hint: cubit.captainInfoModel?.captainInfo![0].vehicleModel.toString(),
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    // controller:cubit.vehicleType,
                    disabled: true,
                    validator: Validator.name,
                  ),
                  InputFormField(
                    hint: cubit.captainInfoModel?.captainInfo![0].vehicleType.toString(),
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    // controller:cubit.vehicleType,
                    validator: Validator.name,
                    disabled: true,
                  ),
                  InputFormField(
                    hint: cubit.captainInfoModel?.captainInfo![0].vehicleNumber.toString(),
                    fillColor: kWhiteColor,
                    verticalMargin: 5,
                    // controller:cubit.vehicleType,
                    disabled: true,
                    validator: Validator.name,
                  ),
                  ConfirmButton(
                    verticalMargin: 30,
                    color: kPrimaryColor,
                    title: 'تغيير كلمة المرور',
                    onPressed:()=>RouteManager.navigateTo(CreateNewPasswordView()),
                  )


                ],
              );
            },
          ),
        )
      ),
    );
  }
}
