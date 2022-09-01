import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/cubit.dart';

import '../../../../constants.dart';
import '../../../../core/router/router.dart';
import '../../picked_location/view.dart';

class Fields extends StatefulWidget {
  const Fields({Key? key}) : super(key: key);

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTripCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Text('حدد تفاصيل الطلب : ',style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor),),
        ),
        InkWell(
          onTap: ()=> RouteManager.navigateTo(
              PickedLocation(
                appTitle: 'ادخل وجهه التسليم',
                onConfirm: (lat, lng, city) {
                  cubit.setSourceLocation(sourceLat: lat, sourceLng: lng, cityName: city);
                  cubit.getCost();
                },
              )
          ),
          splashColor: kPrimaryColor,
          hoverColor: kPrimaryColor,
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.mapMarkerAlt,size: 26,color: kDarkGreyColor,),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ادخل وجهه التسليم',style: Theme.of(context).textTheme.headline6,),
                      Text(cubit.sourceLng == null ? 'تم تحديد وجهه الاستلام وعرض الموقع هنا' : "${cubit.sourceCityName}",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkGreyColor))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: ()=> RouteManager.navigateTo(
              PickedLocation(
                appTitle: 'ادخل وجهه الاستلام',
                onConfirm: (lat, lng, city) {
                  cubit.setDestinationLocation(destinationLat: lat, destinationLng: lng, cityName: city);
                  cubit.getCost();
                },
              )),
          splashColor: kPrimaryColor,
          hoverColor: kPrimaryColor,
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.mapMarkerAlt,size: 26,color: kDarkGreyColor,),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ادخل وجهه الاستلام',style: Theme.of(context).textTheme.headline6,),
                      Text(cubit.destinationLng == null ? 'تم تحديد وجهه الاستلام وعرض الموقع هنا' : "${cubit.destinationCityName}",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkGreyColor))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Text('  حدد الوقت و التاريخ   : ',style: Theme.of(context).textTheme.headline6!.copyWith(color: kPrimaryColor),),
        ),
        InkWell(
          onTap: () {
            showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(2030)
            ).then((date) {
              setState(() {
                cubit.dateTime = date;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.calendarAlt,size: 26,color: kPrimaryColor,),
                SizedBox(width: 20,),
                Text('  حدد التاريخ',style: Theme.of(context).textTheme.headline6!.copyWith(color: kBlueColor),),
                Spacer(),
                Text(cubit.dateTime == null ? 'اضغط لاختيار التاريخ' : reformatDate(cubit.dateTime)),
                // if (cubit.dateTime != null)
                // Text(reformatDate(value),style: Theme.of(context).textTheme.headline6!.copyWith(color: kDarkGreyColor),)
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async{
            TimeOfDay? newTime =  await  showTimePicker(
                context: context,
                initialTime: TimeOfDay.now()
            );
            if(newTime != null)
            {
              setState(() {
                cubit.time = newTime;
              });
              cubit.getCost();
            }
          },
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.clock,size: 26,color: kPrimaryColor,),
                SizedBox(width: 20,),
                Text('  حدد الوقت',style: Theme.of(context).textTheme.headline6!.copyWith(color: kBlueColor),),
                Spacer(),
                Text(cubit.time == null ? 'اضغط لاختيار الوقت' : '${reformatTime(cubit.time!)}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Text('تكلفة الرحلة  : ',style: Theme.of(context).textTheme.headline6!.copyWith(color: kPrimaryColor),),
        ),
        InkWell(
          onTap: cubit.getCost,
          splashColor: kPrimaryColor,
          hoverColor: kPrimaryColor,
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.solidMoneyBillAlt,size: 26,color: kPrimaryColor,),
                SizedBox(width: 20,),
                Text('تكلفة الرحله',style: Theme.of(context).textTheme.headline6!.copyWith(color: kBlueColor),),
                Spacer(),
                Text(cubit.costValue == null ? '0.0' : cubit.costValue!,style: Theme.of(context).textTheme.headline6!.copyWith(color: kPrimaryColor),)

              ],
            ),
          ),
        ),

      ],
    );
  }
}
