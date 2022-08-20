

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/views/captain/edit_profile/cubit/states.dart';
import 'package:soheel_app/views/captain/edit_profile/model.dart';
import 'package:soheel_app/views/shared/trip_details/units/captain_info.dart';
import 'package:soheel_app/views/user/edit_profile/cubit/states.dart';
import 'package:soheel_app/widgets/snack_bar.dart';
import 'package:soheel_app/widgets/toast.dart';

import '../../../../core/dio_manager/dio_manager.dart';

class EditProfileCaptainCubit extends Cubit<EditProfileCaptainStates>{
  EditProfileCaptainCubit() : super(EditProfileCaptainInitState());

  static EditProfileCaptainCubit of(context) => BlocProvider.of(context);
  CaptainInfoModel? captainInfoModel;


  TextEditingController firstNameController = TextEditingController(text: AppStorage.getUserModel()?.firstname.toString());
  TextEditingController lastNameController = TextEditingController(text: AppStorage.getUserModel()?.lastname.toString());
  // TextEditingController vehicleType = TextEditingController(text: captainInfoModel!.captainInfo![0].vehicleType.toString());
  // TextEditingController vehicleName = TextEditingController();
  // TextEditingController vehicleModel = TextEditingController();
  // TextEditingController vehicleNumber = TextEditingController();


  final formKey = GlobalKey<FormState>();

  Future<void> editProfileCaptain () async{
    emit(EditProfileCaptainLoadingState());
    try{
      final response = await DioHelper.post(
          'captain/account',
          data: {
            'logged' : true,
            'captain_id' : AppStorage.customerID
          });
      final data = response.data;
      captainInfoModel = CaptainInfoModel.fromJson(data);

    }catch(e){
      emit(EditProfileCaptainErrorState(e.toString()));
    }
    emit(EditProfileCaptainInitState());
  }


}