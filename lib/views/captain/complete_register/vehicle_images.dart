import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/cubit.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/states.dart';
import 'package:soheel_app/views/captain/complete_register/units/upload_images.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../constants.dart';
import '../../../widgets/logo.dart';

class VehicleImagesView extends StatelessWidget {
  const VehicleImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = CCompleteRegisterCubit.of(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (_, state) => Scaffold(
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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ارفع صور المركبه',style: Theme.of(context).textTheme.headline5!.copyWith(color: kAccentColor),),
                      Text('ارفق صور المركبه  لا يقل عن 2 صور',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UploadImages(
                    images: cubit.vehicleImages,
                    onAdd: cubit.selectVehicleImages,
                    onRemove: cubit.removeVehicleImage,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ارفع الهوية الوطنية أو الاقامة ',style: Theme.of(context).textTheme.headline5!.copyWith(color: kAccentColor),),
                      Text('ارفق صور الهوية الوطنية أو الاقامة  الوجه والظهر  ',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UploadImages(
                    images: cubit.nationalIDImages,
                    onAdd: cubit.selectNationalIDImages,
                    onRemove: cubit.removeNationalIDImage,
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ارفع رخصه المركبه',style: Theme.of(context).textTheme.headline5!.copyWith(color: kAccentColor),),
                      Text('ارفق صور رخصة المركبة الوجه والظهر  ',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UploadImages(
                    images: cubit.vehicleLicensesImages,
                    onAdd: cubit.selectVehicleLicensesImages,
                    onRemove: cubit.removeVehicleLicensesImage,
                  ),
                ],
              ),
              (state is CCompleteRegisterLoadingStates) ? Loading() : ConfirmButton(
                color: kAccentColor,
                horizontalMargin: 10,
                verticalMargin: 10,
                title: 'اتمام التسجيل',
                onPressed: (){
                  if (cubit.validateVehicleImages()) {
                    cubit.completeRegister();
                  } else {
                    showSnackBar('برجاء رفع الصور اولا ');
                  }
                },
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
