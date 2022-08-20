abstract class CCompleteRegisterStates {}

  class CCompleteRegisterInitStates extends CCompleteRegisterStates {}

  class CCompleteRegisterLoadingStates extends CCompleteRegisterStates {}

  class CCompleteRegisterErrorStates extends CCompleteRegisterStates {
  String? error;
  CCompleteRegisterErrorStates(this.error);
}