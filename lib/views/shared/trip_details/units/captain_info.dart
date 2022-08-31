import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/chat/view.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/states.dart';

import '../../../../constants.dart';
import '../../../../widgets/app/loading.dart';

class CaptainInfo extends StatelessWidget {
  const CaptainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsDetailsCubit,TripDetailsStates>(
      builder: (context, state) {
        final cubit = TripsDetailsCubit.of(context);
        final tripDetailsModel = cubit.tripDetailsModel;
        final captainInfo = tripDetailsModel?.captainDetails;
        return captainInfo == null || captainInfo.isEmpty ? SizedBox() :
         Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/captain.png',width: 80,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسم الكابتن',style: Theme.of(context).textTheme.titleLarge,),
                    Text(captainInfo[0].captainName.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () => RouteManager.navigateTo(ChatView(title: captainInfo[0].captainName.toString(), tripID: cubit.tripId!, receiverID: captainInfo[0].captainId!,)),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: kPrimaryColor,
                    child: Icon(FontAwesomeIcons.commentDots,size: 24,),
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                Image.asset('assets/images/truck-1.png',width: 80,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اسم المركبه',style: Theme.of(context).textTheme.titleLarge,),
                    Text(captainInfo[0].vehicleModel.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('النوع',style: Theme.of(context).textTheme.titleLarge,),
                Text(captainInfo[0].vehicleType.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('رقم اللوحه',style: Theme.of(context).textTheme.titleLarge,),
                Spacer(),
                Text(captainInfo[0].vehicleNumber.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('التقييم',style: Theme.of(context).textTheme.titleLarge,),
                Spacer(),
                BlocBuilder<TripsDetailsCubit, TripDetailsStates>(
                  builder: (context, state) {
                    return RatingBar.builder(
                      initialRating:captainInfo[0].captainRating!.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 10,
                        color: kPrimaryColor,
                      ),
                      onRatingUpdate: (rating) {},
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
