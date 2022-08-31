import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/views/captain/commission_bank/cubit/states.dart';
import 'package:soheel_app/views/captain/commission_bank/model.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/states.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

class BankCubit extends Cubit<BankStates>{
  BankCubit() : super(BankInitStates());

  static BankCubit of(context) => BlocProvider.of(context);

  BankModel? bankModel;

  String? senderName, sendingBank , receivingBank , receiptPhoto;
  List<File> imageFileList = [];
  final formKey = GlobalKey<FormState>();

  Future<void> getBanks () async{
    emit(BankLoadingStates());
    try{
      final response = await DioHelper.post(
        'setting/banks_list',
        data: {},
      );
      bankModel = BankModel.fromJson(response.data);
    }catch(e){
      emit(BankErrorStates(e.toString()));
    }
    emit(BankInitStates());
  }


  Future<void> transferAccountBank () async{
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    emit(BankLoadingStates());
    try{
      final formData = await _convertProductDataToFormData();
      final response = await DioHelper.post('captain/account/transfer_commission_bank',formData: formData);
      final data = response.data;
      if (data.containsKey('success')) {
        showSnackBar('تمت العملية بنجاح!');
      } else {
        throw Exception(response.data);
      }
    } catch (e, s) {
      print(e);
      print(s);
      showSnackBar('فشلت العملية!', errorMessage: true);
    }
    emit(BankInitStates());
  }

  Future<FormData> _convertProductDataToFormData() async {
    final data = {
      'captain_id' : AppStorage.customerID,
      'sender_name' : senderName,
      'sending_bank' : sendingBank ,
      'receiving_bank' : receivingBank ,
    };
    final formData = FormData.fromMap(data);
    for (int i = 0; i < imageFileList.length; i++) {
      formData.files.add(MapEntry('receipt_photo[${i}]', await MultipartFile.fromFile(imageFileList[i].path)));
    }
    return formData;

  }

  void selectImages() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      int length = selectedImages.length;
      if (length > (2 - imageFileList.length)) {
        length = 2 - imageFileList.length;
        showSnackBar('عفوا اقصي عدد للصور 2');
      }
      for (int i = 0; i < length; i++) {
        imageFileList.add(File(selectedImages[i].path));
      }
    }
    emit((BankInitStates()));
  }



  bool TransferValidate() {
    return imageFileList.isNotEmpty;
  }

}