import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/permission_manager/permissions_section.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trip_details/view.dart';
import 'package:soheel_app/views/shared/trips/cubit/cubit.dart';
import 'package:soheel_app/views/shared/trips/cubit/states.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/app/empty.dart';
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
                            fontSize: 15, fontWeight: FontWeight.w700),
                        indicator: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: [
                          Tab(
                            text: 'الرحلات المعلقة',
                          ),
                          Tab(
                            text: 'الرحلات النشطة',
                          ),
                          Tab(
                            text: 'الرحلات السابقة',
                          ),
                        ],
                      ) : TabBar(
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        indicator: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                        tabs: [
                          Tab(
                            text: 'الرحلات النشطة',
                          ),
                          Tab(
                            text: 'الرحلات السابقة',
                          ),
                        ],
                      ),
                    ),
                    if (AppStorage.customerGroup == 2)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AppPermissionsSections(),
                      ),
                    Expanded(
                      child:AppStorage.customerGroup == 2 ?  TabBarView(
                        children: [
                          nearestTripsData == null || nearestTripsData.isEmpty ?
                          Stack(
                            children: [
                              Empty(),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: kPrimaryColor,
                                  child:IconButton(
                                    onPressed: () => showSearchArea(cubit),
                                    icon:Icon(FontAwesomeIcons.search,color: kWhiteColor,),
                                  ),
                                ),
                              )
                              // ConfirmButton(
                              //   horizontalMargin: 20,
                              //   verticalMargin: 10,
                              //   title: cubit.getNearestTrips ? 'بحث في نطاق اوسع' : 'بحث في نطاق اضيق',
                              //   onPressed: cubit.getNearestTrip,
                              // ),
                            ],
                          ) :
                          Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
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
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: MaterialButton(
                              //           child: Text('تفاصيل الرحلة',style: TextStyle(color: kWhiteColor,fontWeight: FontWeight.w700),),
                              //           onPressed: (){},
                              //           padding: EdgeInsets.all(10),
                              //           color: kPrimaryColor,
                              //
                              //         ),
                              //       ),
                              //       SizedBox(width: 10,),
                              //       Expanded(
                              //         child: MaterialButton(
                              //           child: Text('قبول الرحلة',style: TextStyle(color: kWhiteColor,fontWeight: FontWeight.w700),),
                              //           onPressed:(){},
                              //           padding: EdgeInsets.all(10),
                              //           color: kPrimaryColor,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          currentTripsData == null || currentTripsData.isEmpty ? Center(
                            child:Empty(),
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
                                  return currentTripsData == null ?  Empty() :
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
                          finishTripsData == null || finishTripsData.isEmpty ? Center(
                            child: Empty(),
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
                        ],
                      ) :
                      TabBarView(
                        children: [
                          currentUserTripsData == null || currentUserTripsData.isEmpty ?  Empty() :
                          RefreshIndicator(
                            onRefresh: TripsCubit.of(context).getUserTrips,
                            backgroundColor: kPrimaryColor,
                            color: kWhiteColor,
                            displacement: 50.0,
                            strokeWidth: 3.0,
                            edgeOffset: 0.0,
                            child: ListView.builder(
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
                          ),
                          finishUserTripsData == null || finishUserTripsData.isEmpty ? Empty() :
                          RefreshIndicator(
                            onRefresh: TripsCubit.of(context).getUserTrips,
                            backgroundColor: kPrimaryColor,
                            color: kWhiteColor,
                            displacement: 50.0,
                            strokeWidth: 3.0,
                            edgeOffset: 0.0,
                            child: ListView.builder(
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



  Future showSearchArea(TripsCubit cubit){
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ابحث في ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      cubit.getNearestTrip(0);
                      RouteManager.pop();
                    },
                    padding: EdgeInsets.all(8),
                    child: Text('نطاقي',style: TextStyle(fontWeight: FontWeight.w700,color: kWhiteColor),),
                    color: kPrimaryColor,
                  ),
                  MaterialButton(
                    onPressed: () {
                      cubit.getNearestTrip(1);
                      RouteManager.pop();
                    },
                    padding: EdgeInsets.all(8),
                    child: Text('نطاق أوسع',style: TextStyle(fontWeight: FontWeight.w700,color: kWhiteColor),),
                    color: kPrimaryColor,
                  ),
                ],
              )
            ],
          ),
        ));
  }



}
