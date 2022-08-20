import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/views/shared/trip_details/cubit/cubit.dart';

class MapSection extends StatelessWidget {
  const MapSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = TripsDetailsCubit.of(context);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: cubit.mapMarkers.first.position,
        zoom: 13,
      ),
      mapType: MapType.normal,
      markers: cubit.mapMarkers,
      polylines: cubit.mapPolyLines,
    );
  }
}
