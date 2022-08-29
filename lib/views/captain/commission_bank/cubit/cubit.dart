import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/views/captain/commission_bank/cubit/states.dart';
import 'package:soheel_app/views/captain/commission_bank/model.dart';

class BankCubit extends Cubit<BankStates>{
  BankCubit() : super(BankInitStates());

  static BankCubit of(context) => BlocProvider.of(context);

  BankModel? bankModel;

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


}