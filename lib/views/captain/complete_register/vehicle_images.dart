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
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
          width: double.infinity,
          child: ListView(
            children: [
              Logo(heightFraction: 6),
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
                      Text('ارفع صور المركبة',style: Theme.of(context).textTheme.headline5!.copyWith(color: kAccentColor),),
                      Text('ارفق صور المركبة  لا يقل عن 2 صور',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
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
                      Text('ارفق صور الهوية الوطنية أو الاقامة  الوجة والظهر  ',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
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
                      Text('ارفع رخصة المركبة',style: Theme.of(context).textTheme.headline5!.copyWith(color: kAccentColor),),
                      Text('ارفق صور رخصة المركبة الوجة والظهر',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
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
                verticalMargin: 20,
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
