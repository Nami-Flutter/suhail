import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/auth/forget_password/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/intro_app/view.dart';

import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../widgets/snack_bar.dart';
import '../../../trips/view.dart';
import '../../login/view.dart';

class ForgetPassCubit extends Cubit<ForgetPassStates>{
  ForgetPassCubit() : super(ForgetPassInitState());

  static ForgetPassCubit of(context) => BlocProvider.of(context);

  String? telephone;
  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword () async{
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(ForgetPassLoadingState());
    try{
      final response = await DioHelper.post(
          'phone_activation/send_new_password',
          data: {
            "telephone" : telephone,
          });

      final data = response.data;
      if(data.containsKey('success'))
        {
          showSnackBar(data['success']);
          RouteManager.pop();
        }else
          {
            showSnackBar(data.toString());
          }
    }catch(e){
      emit(ForgetPassErrorState(e.toString()));
    }
    emit(ForgetPassInitState());
  }




}