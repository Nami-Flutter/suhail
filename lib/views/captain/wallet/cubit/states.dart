abstract class WalletStates {}

class WalletInitStates extends WalletStates {}

class WalletLoadingStates extends WalletStates {}

class WalletErrorStates extends WalletStates {
  String? error;
  WalletErrorStates(this.error);
}