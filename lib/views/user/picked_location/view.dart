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
import 'package:soheel_app/views/user/search_location/view.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

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
  late GoogleMapController googleMapController;

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
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => googleMapController = controller,
            onTap: (LatLng latLng) async {
              Marker m = Marker(
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
            top: 20,
            left: 20,
            right: 20,
            child: InputFormField(
              hint: "بحث",
              fillColor: kWhiteColor,
              icon: Icons.search,
              onTap: () {
                RouteManager.navigateTo(SearchLocationView(
                  onSelect: (latLng) async {
                    cityName = await LocationManager.getCityByLatLng(latitude: latLng.latitude, longitude: latLng.longitude);
                    Marker m = Marker(
                      markerId: MarkerId('1'),
                      position:latLng,
                    );
                    googleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
                    myMarkers.add(m);
                    setState(() {});
                  },
                ));
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right:20,
            left: 20,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kWhiteColor
                    ),
                    child:Row(
                      children: [
                        Icon(FontAwesomeIcons.mapMarkerAlt,size: 26,color: kDarkGreyColor,),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ادخل وجهه الاستلام',style: Theme.of(context).textTheme.headline6,),
                              Text(cityName ?? '', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kDarkGreyColor))
                            ],
                          ),
                        )
                      ],
                    )
                ),
                ConfirmButton(
                  verticalMargin: 20,
                  color: kPrimaryColor,
                  onPressed: (){
                    if (myMarkers.isNotEmpty) {
                      final position = myMarkers.first.position;
                      widget.onConfirm(position.latitude, position.longitude, cityName ?? '');
                      RouteManager.pop();
                    }
                  },
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
