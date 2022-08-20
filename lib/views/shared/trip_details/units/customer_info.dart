import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../../constants.dart';
import '../cubit/states.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsDetailsCubit , TripDetailsStates>(
      builder: (context, state) {
        final cubit = TripsDetailsCubit.of(context).tripDetailsModel;
        final customerInfo = cubit?.tripDetails;
        return customerInfo == null ? Loading() : Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/user.png',width: 80,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسم العميل',style: Theme.of(context).textTheme.titleLarge,),
                    Text(customerInfo.customerName.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: kPrimaryColor,
                  child: Icon(FontAwesomeIcons.commentDots,size: 24,),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('رقم الجوال',style: Theme.of(context).textTheme.titleLarge,),
                Spacer(),
                Text(customerInfo.customerTelephone.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kDarkGreyColor),),
              ],
            ),
          ],
        );
      },
    );
  }
}
