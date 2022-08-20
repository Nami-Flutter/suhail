abstract class ContactUsStates {}

class ContactUsInitState extends ContactUsStates {}

class ContactUsLoadingState extends ContactUsStates {}

class ContactUsErrorState extends ContactUsStates {
  String? error;
  ContactUsErrorState(this.error);
}