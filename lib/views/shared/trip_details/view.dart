import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/states.dart';
import 'package:soheel_app/views/shared/trip_details/units/captain_info.dart';
import 'package:soheel_app/views/shared/trip_details/units/customer_info.dart';
import 'package:soheel_app/views/shared/trip_details/units/map.dart';
import 'package:soheel_app/views/shared/trip_details/units/trip_info.dart';
import 'package:soheel_app/views/shared/trips/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

import '../../../widgets/app_bar.dart';

class TripDetailsView extends StatefulWidget {
  const TripDetailsView({Key? key,required this.tripId}) : super(key: key);
  final String? tripId;

  @override
  _TripDetailsViewState createState() => _TripDetailsViewState();
}

class _TripDetailsViewState extends State<TripDetailsView> {
  bool isCollapsed = true;
  double rating = 0;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => TripsDetailsCubit(widget.tripId)..getTripDetailsData(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل',
          centerTitle: true,
        ),
        body: BlocBuilder<TripsDetailsCubit,TripDetailsStates>(
          builder: (context, state) {
            final cubit = TripsDetailsCubit.of(context);
            return state is TripDetailsLoadingState ? Loading() :
             DefaultTabController(
              length: 2,
              child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                  child: Column(
                    children: [
                      Expanded(
                          flex:isCollapsed ? 1 : 4,
                          child: Stack(
                            children: [
                              MapSection(),
                              Positioned(
                                  bottom: 40,
                                  left: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isCollapsed = !isCollapsed;
                                      });
                                    },
                                    icon: Pulse(
                                      delay: Duration(milliseconds: 300),
                                      child: Icon(
                                        !isCollapsed ? Icons.arrow_circle_up :  Icons.arrow_circle_down,
                                        size: 50,
                                        color: kAccentColor,
                                      ),
                                    ),
                                  ))
                            ],
                          )
                      ),
                      Expanded(
                        // flex: 1 ,
                        child: AnimatedContainer(
                          height: isCollapsed ? 50 : 150,
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              AppStorage.customerGroup == 2 ?  TabBar(
                                labelColor: kPrimaryColor,
                                indicatorColor: kPrimaryColor,
                                unselectedLabelColor: kDarkGreyColor,
                                labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,),
                                tabs: [
                                  Tab(text: 'بيانات العميل',),
                                  Tab(text: 'بيانات الرحلة',),
                                ],
                              ) :
                              TabBar(
                                labelColor: kPrimaryColor,
                                indicatorColor: kPrimaryColor,
                                unselectedLabelColor: kDarkGreyColor,
                                labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,),
                                tabs: [
                                  Tab(text: 'بيانات الكابتن',),
                                  Tab(text: 'بيانات الرحلة',),
                                ],
                              ),
                              Expanded(
                                child: AppStorage.customerGroup == 2 ? TabBarView(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                      child: ListView(
                                        children: [
                                          CustomerInfo()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                      child: ListView(
                                        children: [
                                          TripInfo()
                                        ],
                                      ),
                                    ),
                                  ],
                                ) : TabBarView(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                      child: ListView(
                                        children: [
                                          CaptainInfo(),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                      child: ListView(
                                        children: [
                                          TripInfo(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AppStorage.customerGroup == 1 ?  ConfirmButton(
                                color: kPrimaryColor,
                                onPressed: showRating,
                                horizontalMargin: 20,
                                verticalMargin: 10,
                                title: 'تقييم الرحله',
                              ) :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Builder(
                                    builder: (context) {
                                      Color? color;
                                      String title;
                                      VoidCallback? onTap;
                                      if (cubit.tripDetailsModel?.tripDetails!.tripStatus == "0") {
                                        color = kPrimaryColor;
                                        title = 'الموافقة علي الرحلة';
                                        onTap = cubit.acceptTrip;
                                      } else if (cubit.tripDetailsModel?.tripDetails!.tripStatus == "1") {
                                        color = kAccentColor;
                                        title = 'انهاء الرحلة';
                                        onTap = cubit.finishTrip;
                                      } else if(cubit.tripDetailsModel?.tripDetails!.tripStatus == "2") {
                                        color = kPrimaryColor;
                                        title = 'عودة';
                                        onTap = ()=> RouteManager.navigateTo(TripsView());
                                      }
                                      else{
                                        color = Colors.transparent;
                                        title = '';
                                        onTap = ()=> RouteManager.navigateTo(TripsView());
                                      }
                                      return AppStorage.customerGroup == 2 ? ConfirmButton(
                                        verticalMargin: 20,
                                        onPressed:onTap,
                                        title: title,
                                        color: color,
                                      ) : SizedBox();
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildRating()=> RatingBar.builder(
      itemCount: 5,
      minRating: 1,
      initialRating: rating,
      itemSize: 30,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context,_)=> Icon(FontAwesomeIcons.solidStar,color: kPrimaryColor,),
      updateOnDrag: true,
      onRatingUpdate: (rating)=>setState(() {
        this.rating = rating;
      })
  );

  Future showRating(){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تقييم الرحله'),
              SizedBox(height: 20,),
              buildRating(),
              SizedBox(height: 20,),
              Builder(
                builder: (context) {
                  return ConfirmButton(
                    title: ' اضف تقييمك للرحلة',
                    onPressed: (){
                      TripsDetailsCubit(null).addRate(rating ,widget.tripId!);
                      RouteManager.navigateAndPopAll(TripsView());
                    },
                  );
                },
              )
            ],
          ),
        ));
  }

}
