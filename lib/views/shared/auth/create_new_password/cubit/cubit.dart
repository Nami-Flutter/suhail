import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/shared/auth/create_new_password/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/login/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../../core/app_storage/app_storage.dart';
import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../core/router/router.dart';

class NewPasswordCubit extends Cubit<NewPasswordStates>{
  NewPasswordCubit() : super(NewPasswordInitState());

  static NewPasswordCubit of(context) => BlocProvider.of(context);

  String? password,confirm;
  final formKey = GlobalKey<FormState>();



  Future<void> newPassword () async{
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) return;
    emit(NewPasswordLoadingState());
    try{
        final response = await DioHelper.post(
            'user/account/edit_password',
            data: {
              "logged": true,
              "customer_id" :AppStorage.customerID,
              "password" : password,
              "confirm" : confirm,
            });
        final data = response.data;
        print(data);
        showSnackBar(data['success']);

    }catch(e){
      emit(NewPasswordErrorState(e.toString()));
    }
    emit(NewPasswordInitState());
  }





}