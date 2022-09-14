import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/shared/auth/login/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../../core/app_storage/app_storage.dart';
import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../core/router/router.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.isCaptain) : super(LoginInitState());

  static LoginCubit of(context) => BlocProvider.of(context);

  String? telephone,password;
  final formKey = GlobalKey<FormState>();
  final bool isCaptain;



  Future<void> login () async{
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(LoginLoadingState());
    try{

      if(isCaptain == false) {
        final response = await DioHelper.post(
            'login',
            data: {
              "telephone" : telephone,
              "password" : password,
            });
        final data = response.data;
        if(data['message'] != null)
        {
          showSnackBar(data['message']);
        }else if (data['customer_status'] == '0')
        {
          // activation
          RouteManager.navigateAndPopAll(OtpView(
            customerId: data['customer_id'],
            telephone: telephone!,
            completeRegister: false,
            isCaptain: isCaptain,
          ));
          showSnackBar('برجاء تفعيل رقم الجوال');
        }else if(data['logged'] == true || data['customer_status'] == 1 ){
          await getUserAndCache(data['customer_id'] , data['customer_group']);
          // Home User
          RouteManager.navigateAndPopAll(HomeView());
        }
      }
      if(isCaptain == true) {
        final response = await DioHelper.post(
            'login',
            data: {
              "telephone" : telephone,
              "password" : password,
            });
        final data = response.data;
        if(data['message'] != null)
        {
          showSnackBar(data['message']);
        }else if (data['customer_status'] == '0')
        {
          // activation
          RouteManager.navigateAndPopAll(OtpView(
            customerId: data['customer_id'],
            telephone: telephone!,
            completeRegister: true,
            isCaptain: isCaptain,
          ));
          showSnackBar('برجاء تفعيل رقم الجوال');
        }else if(data['logged'] == true || data['customer_status'] == "1" ){
          await getUserAndCache(data['customer_id'], data['customer_group']);
          // Home User
          RouteManager.navigateAndPopAll(TripsView());
        }
      }


    }catch(e){
      emit(LoginErrorState(e.toString()));
    }
    emit(LoginInitState());
  }





}