abstract class ForgetPassStates {}

class ForgetPassInitState extends ForgetPassStates {}

class ForgetPassLoadingState extends ForgetPassStates {}

class ForgetPassErrorState extends ForgetPassStates {
  String? error;
  ForgetPassErrorState(this.error);
}