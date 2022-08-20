abstract class TripDetailsStates {}

class TripDetailsInitState extends TripDetailsStates {}

class TripDetailsLoadingState extends TripDetailsStates {}

class TripDetailsErrorState extends TripDetailsStates {
  String? error;
  TripDetailsErrorState(this.error);
}

