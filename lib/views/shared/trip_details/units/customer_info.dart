import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/chat/view.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants.dart';
import '../cubit/states.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsDetailsCubit , TripDetailsStates>(
      builder: (context, state) {
        final cubit = TripsDetailsCubit.of(context);
        final tripDetailsModel = cubit.tripDetailsModel;
        final customerInfo = tripDetailsModel?.tripDetails;
        return customerInfo == null ? Loading() : Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/logo.png',width: 50,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسم العميل',style: Theme.of(context).textTheme.titleLarge,),
                    Text(customerInfo.customerName.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () => RouteManager.navigateTo(ChatView(title: customerInfo.customerName ?? '', tripID: cubit.tripId!, receiverID: customerInfo.customerId!,)),
                  child:customerInfo.tripStatus == '1' ? CircleAvatar(
                    radius: 22,
                    backgroundColor: kPrimaryColor,
                    child: Icon(FontAwesomeIcons.commentDots,size: 24,),
                  ) : SizedBox()
                )
              ],
            ),
            Divider(),
            customerInfo.tripStatus == '0' ? SizedBox()  : customerInfo.tripStatus == '1' ?  Row(
              children: [
                Text('رقم الجوال',style: Theme.of(context).textTheme.titleLarge,),
                Spacer(),
                InkWell(
                  onTap: () => launchUrl(Uri.parse('tel:' + customerInfo.customerTelephone!)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: [
                        Text(customerInfo.customerTelephone!,style: TextStyle(color: kDarkGreyColor,fontSize: 22),),
                        SizedBox(width: 10,),
                        Icon(FontAwesomeIcons.phoneAlt,color: kPrimaryColor,),

                      ],
                    ),
                  ),
                ),

                // Text(customerInfo.customerTelephone.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kDarkGreyColor),),
              ],
            ) : SizedBox()
          ],
        );
      },
    );
  }
}
