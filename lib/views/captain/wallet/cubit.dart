import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';

part 'states.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(WalletInit());

  static WalletCubit of(context) => BlocProvider.of(context);

  String? balance;

  Future<void> getWalletBalance() async {
    emit(WalletLoading());
    try {
      final response = await DioHelper.post(
        'captain/account',
        data: {'captain_id': AppStorage.customerID}
      );
      balance = response.data['captain_info'][0]['wallet'];
    } catch (e) {}
    emit(WalletInit());
  }

}