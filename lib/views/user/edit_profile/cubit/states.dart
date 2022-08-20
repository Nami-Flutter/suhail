abstract class EditProfileStates {}

class EditProfileInitState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileErrorState extends EditProfileStates {
  String? error;
  EditProfileErrorState(this.error);
}