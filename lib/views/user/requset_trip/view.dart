import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/intro_app/view.dart';
import 'package:soheel_app/views/user/picked_location/view.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/cubit.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/states.dart';
import 'package:soheel_app/views/user/requset_trip/units/details_field.dart';
import 'package:soheel_app/views/user/requset_trip/units/field_pic.dart';
import 'package:soheel_app/views/user/requset_trip/units/fields.dart';
import 'package:soheel_app/views/user/requset_trip/units/success_order.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

class RequestTripView extends StatefulWidget {
  const RequestTripView({Key? key,required this.appBarTitle,required this.tripCategory}) : super(key: key);
  final String? appBarTitle;
  final String? tripCategory;
  @override
  State<RequestTripView> createState() => _RequestTripViewState();
}

class _RequestTripViewState extends State<RequestTripView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTripCubit(widget.tripCategory)..getSearchTimeLimit(),
      child: Scaffold(
        appBar: appBar(
            title:widget.appBarTitle.toString(),
            centerTitle: true
        ),
        body: BlocBuilder<AddTripCubit,AddTripStates>(
          builder: (context, state) {
            final cubit = AddTripCubit.of(context);
            return Form(
              key: cubit.formKey,
              child: ListView(
                children: [
                  Fields(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ارفق الصور',style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor),),
                          Text('  قم بتحديد الصور و رفعها',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
                        ],
                      )
                  ),
                  PicsUploads(),
                  DetailsFields(),
                  BlocBuilder<AddTripCubit,AddTripStates>(builder: (context, state) {
                   return state is AddTripLoadingState ? Loading() :
                     ConfirmButton(
                     // onPressed: ()=> openDialog() ,
                     onPressed: cubit.costValue == null || cubit.costValue!.isEmpty ? null : (){
                       if(AppStorage.isLogged) {
                         cubit.addTrip();
                       } else {
                         RouteManager.navigateTo(IntroView());
                       }
                     },
                     color: kPrimaryColor,
                     verticalMargin: 20,
                     horizontalMargin: 20,
                     title: 'تاكيد وارسال الطلب',
                   );
                 },)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}



