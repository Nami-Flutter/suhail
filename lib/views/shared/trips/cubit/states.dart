abstract class TripsStates {}

class TripsInitState extends TripsStates {}

class TripsLoadingState extends TripsStates {}

class TripsErrorState extends TripsStates {
  String? error;
  TripsErrorState(this.error);
}