import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/states.dart';
import 'package:soheel_app/widgets/snack_bar.dart';
import '../../../../../core/dio_manager/dio_manager.dart';
import '../units/success_order.dart';

class AddTripCubit extends Cubit<AddTripStates> {
  AddTripCubit(this.tripCategory) : super(AddTripInitState());

  static AddTripCubit of(context) => BlocProvider.of(context);
  final ImagePicker _picker = ImagePicker();
  List<File> imageFileList = [];
  DateTime? dateTime;
  TimeOfDay? time;
  final String? tripCategory;
  String? costValue;
  TextEditingController detailsController = TextEditingController();

  // source وجهه التسليم || destination وجهه الاستلام
  double? sourceLat, sourceLng;
  double? destinationLat, destinationLng;
  String? sourceCityName, destinationCityName;
  final formKey = GlobalKey<FormState>();


  void setSourceLocation({required double sourceLat, required double sourceLng, required String cityName}) {
    this.sourceLat = sourceLat;
    this.sourceLng = sourceLng;
    this.sourceCityName = cityName;
    emit(AddTripInitState());
  }
  void setDestinationLocation({required double destinationLat, required double destinationLng, required String cityName}) {
    this.destinationLat = destinationLat;
    this.destinationLng = destinationLng;
    this.destinationCityName = cityName;
    emit(AddTripInitState());
  }

  Future<void> addTrip() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(AddTripLoadingState());
    final formData = await _convertProductDataToFormData();
    try {
      final response = await DioHelper.post('user/trip/add_trip', formData: formData);
      final data = response.data;
      if (data.containsKey('success')) {
        showSnackBar('تم اضافة الرحلة بنجاح!');
        openDialog(data['trip_id'].toString());
      } else {
        throw Exception(response.data);
      }
    } catch (e, s) {
      print(e);
      print(s);
      showSnackBar('فشلت اضافة الرحلة!', errorMessage: true);
    }
    emit(AddTripInitState());
  }

  Future<void> getCost() async {
    if (sourceLat == null || destinationLng == null || time == null) return;
    final response = await DioHelper.post('user/trip/trip_cost', data: {
      'trip_receipt_long': sourceLng,
      'trip_receipt_lat': sourceLat,
      'trip_delivery_long': destinationLng,
      'trip_delivery_lat': destinationLat,
      'trip_time': time,
    });
    costValue = response.data['cost'].toString();
    emit(AddTripInitState());
  }

  Future<bool> cancelTrip(String tripID) async {
    try {
      final response = await DioHelper.post(
        'user/trip/cancel_trip',
        data: {
          'trip_id': tripID,
          'trip_customer_id': AppStorage.customerID,
        },
      );
      return response.data['success'];
    } catch (e) {}
    return false;
  }

  Future<FormData> _convertProductDataToFormData() async {
    final data = {
      'trip_delivery_long': destinationLng,
      'trip_delivery_lat': destinationLat,
      'trip_delivery_address': destinationCityName,
      'logged': true,
      'trip_customer_id': AppStorage.customerID,
      'trip_category': tripCategory,
      'trip_receipt_long': sourceLng,
      'trip_receipt_lat': sourceLat,
      'trip_receipt_address': sourceCityName,
      'trip_cost': costValue,
      'trip_date': dateTime,
      'trip_time': time,
      'trip_details': detailsController,
    };
    final formData = FormData.fromMap(data);
    for (int i = 0; i < imageFileList.length; i++) {
      formData.files.add(MapEntry('file[${i}]', await MultipartFile.fromFile(imageFileList[i].path)));
    }
    return formData;
  }

  void selectImages() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      int length = selectedImages.length;
      if (length > (5 - imageFileList.length)) {
        length = 5 - imageFileList.length;
        showSnackBar('عفوا اقصي عدد للصور 5');
      }
      for (int i = 0; i < length; i++) {
        imageFileList.add(File(selectedImages[i].path));
      }
    }
    emit(AddTripInitState());
  }


  Future<void> openDialog(String tripId) =>
      showDialog(
          context: RouteManager.currentContext,
          builder: (context) => successOrder(tripId),
      );

}
