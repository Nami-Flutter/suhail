import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/states.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../../constants.dart';

class TripInfo extends StatelessWidget {
  const TripInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsDetailsCubit,TripDetailsStates>(
      builder: (context, state) {
        final cubit = TripsDetailsCubit.of(context);
        final tripDataInfo = cubit.tripDetailsModel?.tripDetails;
        return state is TripDetailsLoadingState ? Text('لا يوجد شئ') : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('موقع التسليم  ',style: Theme.of(context).textTheme.titleLarge,),
                Text(tripDataInfo!.tripDeliveryLat.toString() + '   ' +   tripDataInfo.tripDeliveryLong.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('موقع الاستلام  ',style: Theme.of(context).textTheme.titleLarge,),
                Text(tripDataInfo.tripReceiptLat.toString() + '   ' +   tripDataInfo.tripReceiptLong.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
              ],
            ),
            Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عدد الكيلومترات',style: Theme.of(context).textTheme.titleLarge,),
                    Text( ' Km ' + tripDataInfo.tripDistance.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('  المبلغ المدفوع',style: Theme.of(context).textTheme.titleLarge,),
                    Text( ' R.S ' + tripDataInfo.tripCost.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),)
                ]
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('التاريخ',style: Theme.of(context).textTheme.titleLarge,),
                    Text( reformatDate(tripDataInfo.tripDate),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),)
                  ],
                ),
                Column(
                  children: [
                    Text('الوقت',style: Theme.of(context).textTheme.titleLarge,),
                    Text(tripDataInfo.tripTime.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),)
                  ]
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
