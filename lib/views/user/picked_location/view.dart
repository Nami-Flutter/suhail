import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/location/location_manager.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

class PickedLocation extends StatefulWidget {
  const PickedLocation({Key? key,required this.appTitle, required this.onConfirm}) : super(key: key);
  final String appTitle;
final Function(double lat, double lng, String cityName) onConfirm;
  @override
  State<PickedLocation> createState() => _PickedLocationState();
}

class _PickedLocationState extends State<PickedLocation> {

  String? cityName;

  CameraPosition? cameraPosition;
  // var myMarkers = HashSet<Marker>();
  BitmapDescriptor? customMarker;
  Set<Marker> myMarkers = {};

  @override
  void initState() {
    LocationManager.getLocationFromDevice().then((e) {
      LatLng? latLng = e == null ? null : LatLng(e.latitude, e.longitude);
      cameraPosition = CameraPosition(
        target: latLng != null ? latLng : LatLng(24.692747520803835,46.742969836120594),
        zoom: 14,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: widget.appTitle
      ),
      body: cameraPosition == null ? Loading() : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition!,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onTap: (LatLng latLng) async {
              print('Your Latlng is $latLng');
              Marker m = Marker(
                  infoWindow: InfoWindow(title: 'Here',snippet: 'You Are Here Now'),
                  markerId: MarkerId('1'),
                  position:latLng,
              );
              setState(() {
                myMarkers.add(m);
              });
              cityName = await LocationManager.getCityByLatLng(latitude: latLng.latitude, longitude: latLng.longitude);
              setState(() {});
            },
            markers: myMarkers,
          ),
          Positioned(
            bottom: 20,
            right:10,
            left: 10,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kWhiteColor
                    ),
                    child:Row(
                      children: [
                        Icon(FontAwesomeIcons.mapMarkerAlt,size: 26,color: kDarkGreyColor,),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ادخل وجهه الاستلام',style: Theme.of(context).textTheme.headline6,),
                            Text(cityName ?? '',
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkGreyColor))
                          ],
                        )
                      ],
                    )
                ),
                ConfirmButton(
                  color: kPrimaryColor,
                  onPressed: (){
                    if (myMarkers.isNotEmpty) {
                      final position = myMarkers.first.position;
                      widget.onConfirm(position.latitude, position.longitude, cityName ?? '');
                      RouteManager.pop();
                    }
                  },
                  horizontalMargin: 30,
                  title: 'تأكيد',
                )
              ],
            )

          ),
        ],
      )
    );
  }
}
