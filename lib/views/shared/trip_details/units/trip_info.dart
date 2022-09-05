import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/states.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/image_view.dart';

import '../../../../constants.dart';

class TripInfo extends StatefulWidget {
  const TripInfo({Key? key}) : super(key: key);

  @override
  State<TripInfo> createState() => _TripInfoState();
}

class _TripInfoState extends State<TripInfo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsDetailsCubit,TripDetailsStates>(
      builder: (context, state) {
        final cubit = TripsDetailsCubit.of(context);
        final tripDataInfo = cubit.tripDetailsModel?.tripDetails;
        final imagesList = tripDataInfo!.tripImages;
        return state is TripDetailsLoadingState ? Text('لا يوجد شئ') : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('موقع التسليم  ',style: Theme.of(context).textTheme.titleLarge,),
                Text(tripDataInfo.tripReceiptAddress.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('موقع الاستلام  ',style: Theme.of(context).textTheme.titleLarge,),
                Text(tripDataInfo.tripDeliveryAddress.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor),),
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
                    Text(tripDataInfo.tripCost.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),)
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
            Divider(),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' الصور ',style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 10,),
                  imagesList!.isEmpty ? Text('لا يوجد صور مضافة للرحلة',style: TextStyle(fontSize: 16,),) : CarouselSlider(
                    carouselController: _controller,
                    items: imagesList.map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => RouteManager.navigateTo(ImageView(url: (e.toString()))),
                            child: Image.network(
                              e.toString(),
                              height: 350,
                              fit: BoxFit.cover,
                              width: sizeFromWidth(1),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ]
            ),
            Divider(),
            Column(
                children: [
                  Text('الملاحظات',style: Theme.of(context).textTheme.titleLarge,),
                  tripDataInfo.tripDetails!.isEmpty ? Text('لا يوجد ملاحظات مضافة للرحلة',style: TextStyle(fontSize: 16,),) :
                  Text(tripDataInfo.tripDetails.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kPrimaryColor),)
                ]
            ),



          ],
        );
      },
    );
  }
}
