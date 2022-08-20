abstract class AddTripStates {}

class AddTripInitState extends AddTripStates {}

class AddTripLoadingState extends AddTripStates {}

class AddTripErrorState extends AddTripStates {
  String? error;
  AddTripErrorState(this.error);
}