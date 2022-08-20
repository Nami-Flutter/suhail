import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/complete_register/view.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';

import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../widgets/snack_bar.dart';
import '../../../../captain/complete_register/personal_info.dart';
import '../../../trips/view.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit(this.isCaptain) : super(SignUpInitState());

  static SignUpCubit of(context) => BlocProvider.of(context);

  String? firstname, lastname, telephone, password, confirm;
  final formKey = GlobalKey<FormState>();
  final bool isCaptain;
  bool agreedToTerms = false;

  void toggleAgreedToTerms(bool? value) {
    agreedToTerms = value!;
    emit(SignUpInitState());
  }

  Future<void> signUp() async {
    formKey.currentState!.save();

    if (!formKey.currentState!.validate()) return;
    emit(SignUpLoadingState());

    //Register Captain
    try {
      if (isCaptain == true) {
        final response = await DioHelper.post('captain/register', data: {
          "telephone": telephone,
          "password": password,
          "confirm": confirm,
          "agree": 1
        });
        final data = response.data;
        if (data['message'] != null) {
          showSnackBar(data['message']);
        } else if (data['captain_status'].toString() == '0') {
          print(data['customer_id'].runtimeType);
          RouteManager.navigateTo(OtpView(
            customerId: data['captain_id'],
            telephone: telephone!,
            completeRegister: true,
          ));
          // final response = await DioHelper.post('captain/register_info', data: {
          //   "firstname": firstname,
          //   "lastname": lastname,
          // });

          // RouteManager.navigateAndPopAll(CCompleteRegisterView(telephone: telephone.toString(),));
          // print(data['captain_id']);
          // print(data['captain_status']);
        }
      }
      //Register User
      else if(isCaptain == false) {
        final response = await DioHelper.post('user/register', data: {
          "firstname": firstname,
          "lastname": lastname,
          "telephone": telephone,
          "password": password,
          "confirm": confirm,
        });
        final data = response.data;
        showSnackBar(data.toString());
        if (data['message'] != null) {
          showSnackBar(data['message']);
        } else {
          RouteManager.navigateTo(OtpView(
            customerId: data['customer_id'],
            telephone: telephone.toString(),
            completeRegister: false,
          ));
        }
      }
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
    emit(SignUpInitState());
  }
}
