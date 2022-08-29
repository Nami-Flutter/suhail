import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/widgets/snack_bar.dart';
import '../../../core/moyasar_payment_manager/credit_model.dart';
import '../../../core/moyasar_payment_manager/moyasar_payment_manager.dart';
import '../../../core/moyasar_payment_manager/payment_web_view.dart';
import '../../../core/router/router.dart';

part 'states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit({required this.amount}) : super(PaymentInit());

  static PaymentCubit of(context) => BlocProvider.of(context);

  final double amount;

  final formKey = GlobalKey<FormState>();
  String? month, year, cvv, cardNumber, cardHolderName;

  Future<void> pay() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) return;
    emit(PaymentLoading());
    try {
      final response = await MoyasarPaymentManager.payWithCredit(
        amount: amount,
        creditModel: CreditModel(
          cardHolderName: cardHolderName!,
          cardNumber: cardNumber!,
          cvv: cvv!,
          month: month!,
          year: year!,
        ),
      );
      RouteManager.navigateTo(
        PaymentWebviewView(
          url: response.transactionUrl!,
          paymentCubit: this,
        ),
      );
    } catch (_) {
      emit(PaymentInit());
      showSnackBar('فشلت العملية', errorMessage: true);
    }
  }

  Future<void> sendTransactionID(String transactionID) async {
    final response = await DioHelper.post(
      'captain/account/transfer_commission_master',
      data: {
        'captain_id': AppStorage.customerID,
        'payment_id': transactionID,
        'amount': amount,
      }
    );
    if (response.data['success']) {
      showSnackBar('نجحت العملية!');
      RouteManager.navigateAndPopAll(TripsView());
    } else {
      showSnackBar('فشلت العملية!', errorMessage: true);
    }
  }

}