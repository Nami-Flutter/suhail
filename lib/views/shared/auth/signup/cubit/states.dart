abstract class SignUpStates {}

class SignUpInitState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  String? error;
  SignUpErrorState(this.error);
}