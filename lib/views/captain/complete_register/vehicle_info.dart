import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/cubit.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/states.dart';
import 'package:soheel_app/views/captain/complete_register/model.dart';
import 'package:soheel_app/views/captain/complete_register/vehicle_images.dart';
import 'package:soheel_app/widgets/drop_menu.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

import '../../../constants.dart';
import '../../../core/router/router.dart';
import '../../../widgets/confirm_button.dart';
import '../../../widgets/logo.dart';

class VehicleInfoView extends StatelessWidget {
  const VehicleInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CCompleteRegisterCubit.of(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Scaffold(
        // appBar: appBar(),
        body:Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
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
              Text('  معلومات المركبة ',style: getTextTheme.subtitle1!.copyWith(color: kDarkGreyColor),),
              DropMenu(
                hint: 'نوع الشاحنة',
                items: cubit.categoriesModel?.categories ?? [],
                isItemsModel: true,
                value: cubit.selectedCategory,
                onChanged: (v) => cubit.selectedCategory = v,
              ),
              DropMenu(
                hint: ' الموديل',
                items: cubit.categoriesModel?.manufacturers ?? [],
                isItemsModel: true,
                value: cubit.selectedManufacturer,
                onChanged: (v) async {
                  cubit.selectedManufacturerDetail = null;
                  cubit.manufacturerDetailsModel = null;
                  cubit.selectedManufacturer = v;
                  cubit.manufacturerDetailsYears.clear();
                  await cubit.getManufacturerDetails(v.id);
                },
              ),
              DropMenu(
                hint: 'النوع',
                value: cubit.selectedManufacturerDetail,
                items: cubit.manufacturerDetailsModel?.manufacturerDetails ?? [],
                isItemsModel: true,
                onChanged: (v) {
                  cubit.selectedModelYear = null;
                  cubit.selectedManufacturerDetail = v;
                  cubit.manufacturerDetailsYears.clear();
                  cubit.getManufacturerYears();
                },
              ),
              DropMenu(
                hint: 'سنة التصنيع',
                value: cubit.selectedModelYear,
                onChanged: (v) {
                  cubit.selectedModelYear = v;
                },
                items: cubit.manufacturerDetailsYears,
              ),
              InputFormField(
                hint: 'رقم اللوحة',
                fillColor: kWhiteColor,
                verticalMargin: 5,
                controller: cubit.platformNumberController,
                validator: Validator.number,
              ),
              SizedBox(height: 20,),
              ConfirmButton(
                title: 'التالي',
                border: false,
                verticalMargin: 5,
                onPressed: (){
                  if (cubit.validateVehicleInfo()) {
                    final i = cubit.currentIndex+1;
                    cubit.toggleView(i);
                  }
                },
                color: kAccentColor,
              ),
              ConfirmButton(
                title: 'عودة',
                border: false,
                verticalMargin: 10,
                onPressed: (){
                  final i = cubit.currentIndex-1;
                  cubit.toggleView(i);
                },
                color: kAccentColor,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
