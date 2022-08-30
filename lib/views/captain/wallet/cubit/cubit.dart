import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/views/captain/commission_bank/cubit/states.dart';
import 'package:soheel_app/views/captain/commission_bank/model.dart';
import 'package:soheel_app/views/captain/wallet/cubit/states.dart';

class WalletCubit extends Cubit<WalletStates>{
  WalletCubit() : super(WalletInitStates());

  static WalletCubit of(context) => BlocProvider.of(context);

  String? account;


  Future<void> getWalletBalance () async{
    emit(WalletLoadingStates());
    try{
      final response = await DioHelper.post(
          'captain/account',
          data: {
            'captain_id' : AppStorage.customerID
          });
      final data = response.data;
      account = data['captain_info'][0]['wallet'];
      print(account);


    }catch(e){
      emit(WalletErrorStates(e.toString()));
    }
    emit(WalletInitStates());
  }


}