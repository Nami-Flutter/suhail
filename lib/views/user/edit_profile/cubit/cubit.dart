

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/edit_profile/cubit/states.dart';
import 'package:soheel_app/widgets/snack_bar.dart';
import 'package:soheel_app/widgets/toast.dart';

import '../../../../core/dio_manager/dio_manager.dart';

class EditProfileCubit extends Cubit<EditProfileStates>{
  EditProfileCubit() : super(EditProfileInitState());

  static EditProfileCubit of(context) => BlocProvider.of(context);

  TextEditingController firstNameController = TextEditingController(text: AppStorage.getUserModel()?.firstname.toString());
  TextEditingController lastNameController = TextEditingController(text: AppStorage.getUserModel()?.lastname.toString());
  TextEditingController telephoneController = TextEditingController(text: AppStorage.getUserModel()?.telephone.toString());
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> editProfile () async{
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(EditProfileLoadingState());
    try{
      final response = await DioHelper.post(
          'user/account/edit_info',
          data: {
            'logged' : true,
            'customer_id' : AppStorage.getUserModel()?.customerId,
            'firstname' : firstNameController.text,
            'lastname' : lastNameController.text,
            'telephone' : telephoneController.text,
          });
      final data = response.data;
      if(data.containsKey('success'))
      {
        print(AppStorage.getUserModel()?.customerId);
        print(AppStorage.getUserModel()?.firstname);
        print(AppStorage.getUserModel()?.lastname);
        print(AppStorage.getUserModel()?.telephone);

        showSnackBar(data['success']);
        getUserAndCache(AppStorage.customerID , AppStorage.customerGroup);
        // RouteManager.navigateTo(TripsView());
      }else if(data.containsKey('message'))
      {
        showToast(data['message']);
      }
    }catch(e){
      emit(EditProfileErrorState(e.toString()));
    }
    emit(EditProfileInitState());
  }


}