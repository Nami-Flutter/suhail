// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:soheel_app/core/router/router.dart';
// import 'package:soheel_app/views/user/home/view.dart';
// import 'package:soheel_app/views/user/picked_location/states.dart';
//
// import '../../../core/location/location_manager.dart';
//
//
// class SelectLocationFromMapCubit extends Cubit<SelectLocationFromMapStates> {
//   SelectLocationFromMapCubit() : super(SelectLocationLoadingStates());
//
//   static SelectLocationFromMapCubit of(context) => BlocProvider.of(context);
//
//   LatLng? initialLocation;
//   Set<Marker> mapMarkers = {};
//
//   Future<void> initialize() async {
//     try {
//       final position = await LocationManager.getLocationFromDevice();
//       if (position != null) {
//         initialLocation = LatLng(position.latitude, position.longitude);
//       } else {
//         throw Exception('Can not get location');
//       }
//     } catch (e) {
//       // initialLocation = DEFAULT_LAT_LNG;
//     }
//     final marker = Marker(markerId: MarkerId('location'), position: initialLocation!);
//     mapMarkers.add(marker);
//     emit(SelectLocationInitStates());
//   }
//
//   void pickLocation(LatLng latLng) {
//     final marker = Marker(markerId: MarkerId('location'), position: latLng);
//     mapMarkers.clear();
//     mapMarkers.add(marker);
//     emit(SelectLocationInitStates());
//   }
//
//   void updateLocation() async {
//     emit(SelectLocationLoadingStates());
//     try {
//       final marker = mapMarkers.first;
//       // await LocationManager.setLocation(marker.position);
//       RouteManager.navigateAndPopAll(HomeView());
//     } catch (e) {
//       // showInternetErrorMessage();
//       emit(SelectLocationInitStates());
//     }
//   }
//
// }