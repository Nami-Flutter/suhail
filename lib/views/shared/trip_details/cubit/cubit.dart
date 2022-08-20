import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/location/location_manager.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/states.dart';
import 'package:soheel_app/views/shared/trip_details/model.dart';
import 'package:soheel_app/views/shared/trips/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/current_trip_model.dart';
import 'package:soheel_app/views/shared/trips/finish_trip_model.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../core/dio_manager/dio_manager.dart';

class TripsDetailsCubit extends Cubit<TripDetailsStates> {
  TripsDetailsCubit(this.tripId,) : super(TripDetailsInitState());

  static TripsDetailsCubit of(context) => BlocProvider.of(context);
  final String? tripId;
  double? rating;

  TripDetailsModel? tripDetailsModel;
  Set<Marker> mapMarkers = {};
  Set<Polyline> mapPolyLines = {};

  Timer? _timer;
  Future<void> initTracking() async {
    if (AppStorage.customerGroup == 1 && tripDetailsModel?.tripDetails?.tripStatus == '1') {
      // TODO: Upgrade Duration to 10 / 20
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        final location = await LocationManager.getCaptainLocationFromServer(tripDetailsModel!.captainDetails![0].captainId!);
        if (location != null)
        mapMarkers.add(
          Marker(
            markerId: MarkerId('captain'),
            position: location,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        );
        emit(TripDetailsInitState());
      });
    }
  }

  Future<void> getTripDetailsData() async {
    emit(TripDetailsLoadingState());
    try {
      final response = await DioHelper.post(
          'user/trip/trip_details',
          data: {
            "trip_id": tripId
          });
      tripDetailsModel = TripDetailsModel.fromJson(response.data);
      await initMap();
      initTracking();
    } catch (e) {
      emit(TripDetailsErrorState(e.toString()));
    }
    emit(TripDetailsInitState());
  }

  Future<void> initMap() async {
    final receiptLat = double.parse(tripDetailsModel!.tripDetails!.tripReceiptLat!);
    final receiptLong = double.parse(tripDetailsModel!.tripDetails!.tripReceiptLong!);
    final deliveryLat = double.parse(tripDetailsModel!.tripDetails!.tripDeliveryLat!);
    final deliveryLong = double.parse(tripDetailsModel!.tripDetails!.tripDeliveryLong!);
    final receipt = LatLng(receiptLat, receiptLong);
    final delivery = LatLng(deliveryLat, deliveryLong);
    mapMarkers.add(
      Marker(
        markerId: MarkerId("receipt"),
        infoWindow: InfoWindow(
          title: "وجهه الاستلام",
        ),
        position: receipt,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      )
    );
    mapMarkers.add(
        Marker(
          markerId: MarkerId("delivery"),
          infoWindow: InfoWindow(
            title: "وجهه التسليم"
          ),
          position: delivery,
        )
    );
    mapPolyLines = await LocationManager.drawPolyLine(receipt, delivery);
  }


  Future<void> finishTrip() async {
    emit(TripDetailsLoadingState());

    try {
      final response = await DioHelper.post('captain/location/end_trip',
          data: {
            "trip_id": tripId,
            "captain_id" : AppStorage.customerID
          });
      final data = response.data;
      if (data['success'] == true){
        showSnackBar('تم انهاء الرحله بنجاح');
        RouteManager.navigateAndPopAll(TripsView());
      }
      else{
        showSnackBar('حدث خطأ');

      }
    } catch (e) {
      emit(TripDetailsErrorState(e.toString()));
    }
    emit(TripDetailsInitState());
  }

  Future<void> acceptTrip() async {
    emit(TripDetailsLoadingState());

    try {
      final response = await DioHelper.post('captain/location/accept_trip',
          data: {
            "trip_id": tripId,
            "captain_id" : AppStorage.customerID,
          });
      final data = response.data;
      if (data['success'] == true){
        showSnackBar('تمت الموافقه علي الرحله بنجاح');
        RouteManager.navigateAndPopAll(TripsView());
      }
      else{
        showSnackBar('حدث خطأ');

      }
    } catch (e) {
      emit(TripDetailsErrorState(e.toString()));
    }
    emit(TripDetailsInitState());
  }

  // Future<void> addRate() async {
  //   emit(TripDetailsLoadingState());
  //
  //   try {
  //     final response = await DioHelper.post('user/trip/add_rating',
  //         data: {
  //           "trip_id": tripId,
  //           "captain_id" : AppStorage.customerID,
  //           "rating" : rating,
  //         });
  //     final data = response.data;
  //     if (data['success'] == true){
  //       showSnackBar('تم التقييم بنجاح');
  //     }
  //     else{
  //       showSnackBar('حدث خطأ');
  //
  //     }
  //   } catch (e) {
  //     emit(TripDetailsErrorState(e.toString()));
  //   }
  //   emit(TripDetailsInitState());
  // }

@override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }


}


/*


        "trip_delivery_long": "46.70936712158202",
        "trip_delivery_lat": "24.65410124229380",
        "trip_delivery_address": "جدة, السعودية",
        "trip_cost": "20 ريال",
        "trip_date": "2020-12-16",
        "trip_time": "19:30:10",
        "trip_details": "نص تعليق على الرحلة",
        "trip_distance": 11,
        "trip_images": [],
        "trip_status": "2",
        "payment_flag": 0,
        "payment_method": ""

{
        "trip_id": "148",
        "customer_id": "258",
        "customer_name": "aliii test",
        "customer_telephone": "0510203040",
        "trip_category": "168",
        "trip_receipt_long": "46.8127072705078",
        "trip_receipt_lat": "24.680308703868064",
        "trip_receipt_address": "الرياض, السعودية",
        "trip_delivery_long": "46.70936712158202",
        "trip_delivery_lat": "24.65410124229380",
        "trip_delivery_address": "جدة, السعودية",
        "trip_cost": "20 ريال",
        "trip_date": "2020-12-16",
        "trip_time": "19:30:10",
        "trip_details": "نص تعليق على الرحلة",
        "trip_distance": 11,
        "trip_images": [],
        "trip_status": "2",
        "payment_flag": 0,
        "payment_method": ""
    },

 */