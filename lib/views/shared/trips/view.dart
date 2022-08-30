import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/view.dart';
import 'package:soheel_app/views/shared/trips/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trips/cubit/states.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/drawer.dart';

import '../../../widgets/app/trip_card.dart';
import '../../../widgets/app_bar.dart';

class TripsView extends StatefulWidget {
  const TripsView({Key? key}) : super(key: key);

  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:DefaultTabController(
        length: AppStorage.customerGroup == 2 ? 3 : 2,
        child: BlocProvider(
          create: (context) => TripsCubit()..getNearestTrip()..getCurrentTrips()..getFinishTrips()..getUserTrips(),
          child: BlocBuilder<TripsCubit, TripsStates>(
            builder: (context, state) {
              final cubit = TripsCubit.of(context);
              final currentTripsData = cubit.currentTripsModel?.currentTrips;
              final finishTripsData = cubit.finishTripsModel?.completedTrips;
              final nearestTripsData = cubit.nearestTripModel?.trips;
              // رحلات المستخدم المنتهيه و الحاليه
              final currentUserTripsData = cubit.allUserTripsModel?.currentTrips;
              final finishUserTripsData = cubit.allUserTripsModel?.completedTrips;

              return state is TripsLoadingState ? Loading() : Scaffold(
                appBar: appBar(
                  title: 'سهيل',
                  centerTitle: true,
                ),
                drawer: drawer(),
                body: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: kDarkGreyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: AppStorage.customerGroup == 2 ? TabBar(
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        indicator: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: [
                          Tab(
                            text: 'الرحلات المعلقة',
                          ),
                          Tab(
                            text: 'الرحلات السابقة',
                          ),
                          Tab(
                            text: 'الرحلات النشطة',
                          ),
                        ],
                      ) : TabBar(
                        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        indicator: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                        tabs: [
                          Tab(
                            text: 'الرحلات السابقة',
                          ),
                          Tab(
                            text: 'الرحلات النشطة',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:AppStorage.customerGroup == 2 ?  TabBarView(
                        children: [
                          nearestTripsData == null || nearestTripsData.isEmpty ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('لا توجد رحلات', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                              ConfirmButton(
                                horizontalMargin: 20,
                                verticalMargin: 10,
                                title: cubit.getNearestTrips ? 'بحث في نطاق اوسع' : 'بحث في نطاق اضيق',
                                onPressed: cubit.getNearestTrip,
                              ),
                            ],
                          ) :
                          RefreshIndicator(
                            onRefresh: TripsCubit.of(context).getNearestTrip,
                            backgroundColor: kPrimaryColor,
                            color: kWhiteColor,
                            displacement: 50.0,
                            strokeWidth: 3.0,
                            edgeOffset: 0.0,
                            child: Column(
                              children: [
                                ListView.builder(
                                    itemBuilder: (context, index) {
                                       return TripCard(
                                        image: 'assets/images/truck-1.png',
                                        status: nearestTripsData[index].name.toString(),
                                        truckType:nearestTripsData[index].cost.toString(),
                                        onTap: () => RouteManager.navigateTo(
                                          TripDetailsView(tripId: nearestTripsData[index].tripId.toString(),),),
                                      );
                                    },
                                    itemCount: nearestTripsData.length
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                          child: Text('تفاصيل الرحلة',style: TextStyle(color: kWhiteColor,fontWeight: FontWeight.w700),),
                                          onPressed: (){},
                                          padding: EdgeInsets.all(10),
                                          color: kPrimaryColor,

                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: MaterialButton(
                                          child: Text('قبول الرحلة',style: TextStyle(color: kWhiteColor,fontWeight: FontWeight.w700),),
                                          onPressed: (){},
                                          padding: EdgeInsets.all(10),
                                          color: kPrimaryColor,
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          finishTripsData == null || finishTripsData.isEmpty ? Center(
                            child: Text('لا توجد رحلات',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                          ):
                          RefreshIndicator(
                            onRefresh: TripsCubit.of(context).getFinishTrips,
                            backgroundColor: kPrimaryColor,
                            color: kWhiteColor,
                            displacement: 50.0,
                            strokeWidth: 3.0,
                            edgeOffset: 0.0,
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return finishTripsData == null ? Text('لا توجد بيانات') :
                                   TripCard(
                                    image:
                                    'assets/images/truck-1.png',
                                    status: finishTripsData[index].name.toString(),
                                    truckType:
                                    finishTripsData[index].cost.toString(),
                                    onTap: () =>
                                        RouteManager.navigateTo(
                                          TripDetailsView(tripId: finishTripsData[index].tripId.toString(),),),
                                  );
                                },
                                itemCount: finishTripsData.length),
                          ),
                          currentTripsData == null || currentTripsData.isEmpty ? Center(
                            child: Text('لا توجد رحلات',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                          ):
                          RefreshIndicator(
                            onRefresh: TripsCubit.of(context).getCurrentTrips,
                            backgroundColor: kPrimaryColor,
                            color: kWhiteColor,
                            displacement: 50.0,
                            strokeWidth: 3.0,
                            edgeOffset: 0.0,
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return currentTripsData == null ? Text('لا توجد رحلات') :
                                   TripCard(
                                   image: 'assets/images/truck-1.png',
                                   status:currentTripsData[index].name.toString(),
                                   truckType: currentTripsData[index].cost.toString(),
                                   onTap: () => RouteManager.navigateTo(TripDetailsView(
                                       tripId: currentTripsData[index].tripId.toString()
                                   ),
                                   ),
                                   );
                                },
                                itemCount: currentTripsData.length),
                          ),
                        ],
                      ) :
                      TabBarView(
                        children: [
                          finishUserTripsData == null || finishUserTripsData.isEmpty ? Center(child: Text('لا توجد رحلات'),) :
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return TripCard(
                                image:
                                'assets/images/truck-1.png',
                                status:
                                finishUserTripsData[index].name.toString(),
                                truckType: finishUserTripsData[index].cost.toString(),
                                onTap: () =>
                                    RouteManager.navigateTo(
                                      TripDetailsView(
                                        tripId: finishUserTripsData[index].tripId,
                                      ),
                                    ),
                              );
                            },
                            itemCount: finishUserTripsData.length,
                          ),
                          currentUserTripsData == null || currentUserTripsData.isEmpty ? Center(child: Text('لا توجد رحلات'),) :
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return TripCard(
                                image: 'assets/images/truck-1.png',
                                status: currentUserTripsData[index].name.toString(),
                                truckType: currentUserTripsData[index].cost.toString(),
                                onTap: () =>
                                    RouteManager.navigateTo(
                                      TripDetailsView(
                                        tripId: currentUserTripsData[index].tripId,
                                      ),
                                    ),
                              );
                            },
                            itemCount:currentUserTripsData.length,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),),
      ),
    );
  }
}
