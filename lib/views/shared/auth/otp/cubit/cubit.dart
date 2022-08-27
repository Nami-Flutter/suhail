import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/captain/complete_register/view.dart';
import 'package:soheel_app/views/shared/auth/login/view.dart';
import 'package:soheel_app/views/shared/auth/otp/cubit/states.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../core/router/router.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit({required this.telephone, required this.customerId, required this.completeRegister}) : super(OtpInitStates());

  static OtpCubit of(context) => BlocProvider.of(context);
  final int customerId;
  String? code;
  final formKey = GlobalKey<FormState>();
  final String? telephone;
  final bool completeRegister;

  Future<void> activate() async{
    emit(OtpLoadingStates());
    try{
      final response = await DioHelper.post('captain/register_activation',
          data: {
            'customer_id' : customerId,
            "code" : code
          });
      final data = response.data;
      if(data['success'] == true){
        RouteManager.navigateAndPopAll(completeRegister ? CCompleteRegisterView(telephone: telephone!,) : HomeView());
      }else {
        showSnackBar(data['message']);
      }
      emit(OtpErrorStates(e.toString()));
    }catch(e, s){
      print(e);
      print(s);
    }
  }

  Future<void> resendCode() async {
    try {
      final response = await DioHelper.post('login/resend_code',
          data: {
            "telephone" : telephone,
          });
      final data = response.data;
      showSnackBar(data['success'] ? 'تم ارسال الكود بنجاح!' : 'فشل ارسال الكود!');
    } catch (e){
      showSnackBar('فشل ارسال الكود!');
      rethrow;
    }
  }


}