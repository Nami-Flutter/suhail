import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants.dart';
import '../../widgets/snack_bar.dart';
import '../app_storage/app_storage.dart';
import '../dio_manager/dio_manager.dart';

class LocationManager {

  static Position? currentDevicePosition;
  static LatLng? currentLocationFromServer;

  static Future<Position?> getLocationFromDevice() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showLocationErrorBar();
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showLocationErrorBar();
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showLocationErrorBar();
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    currentDevicePosition = position;
    return position;
  }

  static bool _isLocationStreamInit = false;
  static Future<void> initLocationStream() async {
    if (_isLocationStreamInit) {
      return;
    }
    _isLocationStreamInit = true;
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        // TODO : Specify DistanceMeter
        distanceFilter: 10,
      )
    ).listen((event) {
      if (AppStorage.customerGroup == 2 && AppStorage.isLogged)
        setLocation(LatLng(event.latitude, event.longitude));
    });
  }

  static Future<bool> setLocation([LatLng? latLng]) async {
    try {
      Position? position;
      if (latLng == null)
        position = await getLocationFromDevice();
      currentLocationFromServer = LatLng(position?.latitude ?? latLng!.latitude, position?.longitude ?? latLng!.longitude);
      print({
        "captain_id" : AppStorage.customerID,
        "location_long" : latLng?.longitude ?? currentLocationFromServer!.longitude,
        "location_lat" : latLng?.latitude ?? currentLocationFromServer!.latitude,
      });

      final response = await DioHelper.post(
        'captain/location/set_location',
        data: {
          "captain_id" : AppStorage.customerID,
          "location_long" : latLng?.longitude ?? currentLocationFromServer!.longitude,
          "location_lat" : latLng?.latitude ?? currentLocationFromServer!.latitude,
        },
      );
      if (response.data['success']) {
        return true;
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    showLocationErrorBar();
    return false;
  }

  static Future<LatLng?> getCaptainLocationFromServer(String captainID) async {
    try {
      final response = await DioHelper.post('captain/location/get_location',
          data: {
            "captain_id" : captainID,
          });
      final data = response.data;
      return LatLng(double.parse(data['location_lat']), double.parse(data['location_long']));
    } catch(e) {
      print(e);
    }
    return null;
  }

  static void showLocationErrorBar() => showSnackBar('غير قادر علي تحديد موقعك!', errorMessage: true);

  static Future<String> getCityByLatLng({required double latitude,required double longitude})async{
    String? location;
    final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$MAP_API_KEY&language=ar';
    final response = await Dio().post(url);
    if(response.statusCode == 200){
      final data = response.data;
      location = data['results'][1]['address_components'][2]['short_name'];
      return location!;
    }else
      throw Exception('Cannot get City by LatLng');
  }

  static Future<Set<Polyline>> drawPolyLine(LatLng start,LatLng end) async{
    List<LatLng> polylineCoordinates = [];
    Map<PolylineId, Polyline> polyLines = {};
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      MAP_API_KEY,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id, color: kPrimaryColor, points: polylineCoordinates);
      polyLines[id] = polyline;
    }
    return Set<Polyline>.of(polyLines.values);
  }

}