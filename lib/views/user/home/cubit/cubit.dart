import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/shared/auth/login/cubit/states.dart';
import 'package:soheel_app/views/shared/auth/otp/view.dart';
import 'package:soheel_app/views/shared/auth/signup/cubit/states.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/views/user/home/cubit/states.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../../core/app_storage/app_storage.dart';
import '../../../../../core/dio_manager/dio_manager.dart';
import '../../../../../core/router/router.dart';
import '../../../../core/location/location_manager.dart';
import '../category_model.dart';

class HomeCategoryCubit extends Cubit<CategoryStates>{
  HomeCategoryCubit() : super(CategoryInitState());

  static HomeCategoryCubit of(context) => BlocProvider.of(context);

  CategoryModel? categoryModel;

  Future<void> homeCategoryData () async{
    emit(CategoryLoadingState());
    try{
      LocationManager.getLocationFromDevice();
      final response = await DioHelper.post(
          'user/categories',
          data: {});
      final data = response.data;
      categoryModel = CategoryModel.fromJson(data);
    }catch(e){
      emit(CategoryErrorState(e.toString()));
    }
    emit(CategoryInitState());
  }


}