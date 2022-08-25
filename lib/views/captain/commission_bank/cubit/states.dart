abstract class BankStates {}

class BankInitStates extends BankStates {}

class BankLoadingStates extends BankStates {}

class BankErrorStates extends BankStates {
  String? error;
  BankErrorStates(this.error);
}