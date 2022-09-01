import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/contact_us/cubit/states.dart';
import 'package:soheel_app/views/shared/contact_us/model.dart';
import 'package:soheel_app/views/shared/contact_us/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

class ContactUsCubit extends Cubit<ContactUsStates>{
  ContactUsCubit() : super(ContactUsInitState());

  static ContactUsCubit of(context) => BlocProvider.of(context);

  ContactInfoModel? contactInfoModel;

  String? enquiry;
  final formKey = GlobalKey<FormState>();


  Future<void> contactUs () async{
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(ContactUsLoadingState());
    try{
      final response = await DioHelper.post(
          'contact',
          data: {
            "name" : AppStorage.getUserModel()!.firstname,
            "telephone" :  AppStorage.getUserModel()!.telephone,
            "enquiry" : enquiry,
          });
      final data = response.data;
      contactInfoModel = ContactInfoModel.fromJson(data);
      if(data.containsKey('success')){
        showSnackBar(data['success']);
        RouteManager.navigateTo(HomeView());
      }
    }catch(e){
      emit(ContactUsErrorState(e.toString()));
    }
    emit(ContactUsInitState());
  }

  Future<void> getContactData () async{
    emit(ContactUsLoadingState());
    try{
      final response = await DioHelper.post(
          'contact/contact_info',
          data: {});
      final data = response.data;
      contactInfoModel = ContactInfoModel.fromJson(data);
    }catch(e){
      emit(ContactUsErrorState(e.toString()));
    }
    emit(ContactUsInitState());
  }



}