abstract class OtpStates {}

class OtpInitStates extends OtpStates {}

class OtpLoadingStates extends OtpStates {}

class OtpErrorStates extends OtpStates {
  String? error;
  OtpErrorStates(this.error);
}