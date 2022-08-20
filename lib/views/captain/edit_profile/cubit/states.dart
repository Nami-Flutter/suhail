abstract class EditProfileCaptainStates {}

class EditProfileCaptainInitState extends EditProfileCaptainStates {}

class EditProfileCaptainLoadingState extends EditProfileCaptainStates {}

class EditProfileCaptainErrorState extends EditProfileCaptainStates {
  String? error;
  EditProfileCaptainErrorState(this.error);
}