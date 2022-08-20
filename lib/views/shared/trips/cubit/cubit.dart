import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/location/location_manager.dart';
import 'package:soheel_app/views/shared/trips/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/current_trip_model.dart';
import 'package:soheel_app/views/shared/trips/finish_trip_model.dart';
import 'package:soheel_app/views/shared/trips/nearst_trip_model.dart';
import 'package:soheel_app/views/shared/trips/user_trips_model.dart';

import '../../../../core/dio_manager/dio_manager.dart';

class TripsCubit extends Cubit<TripsStates> {
  TripsCubit() : super(TripsInitState());

  static TripsCubit of(context) => BlocProvider.of(context);

  CurrentTripsModel? currentTripsModel;
  FinishTripsModel? finishTripsModel;
  AllUserTripsModel? allUserTripsModel;
  NearestTripModel? nearestTripModel;

  double? captainLat, captainLng;
  bool getNearestTrips = false;

  Future<void> getCurrentTrips() async {
    emit(TripsLoadingState());
    if(AppStorage.customerGroup == 2)
    try {
      await LocationManager.setLocation();
      final response = await DioHelper.post('captain/location/get_current_trips',
          data: {
          "captain_id" : AppStorage.customerID
          });
      currentTripsModel = CurrentTripsModel.fromJson(response.data);
    } catch (e) {
      emit(TripsErrorState(e.toString()));
    }
    emit(TripsInitState());
  }

  Future<void> getFinishTrips() async {
    emit(TripsLoadingState());
    if(AppStorage.customerGroup == 2)
    try {
      final response = await DioHelper.post('captain/location/get_finished_trips',
          data: {
            "captain_id" : AppStorage.customerID
          });
      finishTripsModel = FinishTripsModel.fromJson(response.data);
    } catch (e) {
      emit(TripsErrorState(e.toString()));
    }
    emit(TripsInitState());
  }

  Future<void> getUserTrips() async {
    emit(TripsLoadingState());
    if(AppStorage.customerGroup == 1)
      try {
        final response = await DioHelper.post('user/trip/get_user_trips',
            data: {
              "customer_id" : AppStorage.customerID
            });
        allUserTripsModel = AllUserTripsModel.fromJson(response.data);
      } catch (e) {
        emit(TripsErrorState(e.toString()));
      }
    emit(TripsInitState());
  }

  Future<void> getNearestTrip() async {
    getNearestTrips = !getNearestTrips;
    LocationManager.initLocationStream();
    emit(TripsLoadingState());
    if(AppStorage.customerGroup == 2)
      try {
        final response = await DioHelper.post('captain/location/get_nearest_trips',
            data: {
              "captain_id" : AppStorage.customerID,
              "max_limit" : getNearestTrips ? 0 : 1,
            });
        nearestTripModel = NearestTripModel.fromJson(response.data);
      } catch (e) {
        emit(TripsErrorState(e.toString()));
      }
    emit(TripsInitState());
  }


}
