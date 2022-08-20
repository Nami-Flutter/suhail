abstract class NewPasswordStates {}

class NewPasswordInitState extends NewPasswordStates {}

class NewPasswordLoadingState extends NewPasswordStates {}

class NewPasswordErrorState extends NewPasswordStates {
  String? error;
  NewPasswordErrorState(this.error);
}