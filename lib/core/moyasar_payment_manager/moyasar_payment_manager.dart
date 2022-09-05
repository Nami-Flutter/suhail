import 'dart:convert';
import 'package:moyasar_payment/flutter_pay.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/model/source/stcpaymodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';
import 'credit_model.dart';

abstract class MoyasarPaymentManager {

  static MoyasarPayment _moyasarPayment = MoyasarPayment();
  static const String _publishableKey = "pk_test_2JRzLVTe5acWqQww1NtM9hexh9QRGVJFMXbf8b7z";
  static const String _secretKey = "sk_test_BhctT2BCxcLMEFZNZ75eNvbsAmYg4rdFS6ugjkrk";
  // static const String _applePayMerchantID = "merchant.tamhir.app.pay";

  static Future<CreditcardModel> payWithCredit({
    required double amount,
    required CreditModel creditModel,
  }) async {
    PayModel res = await _moyasarPayment.creditCard(
      description: 'Paying for a service with Credit/Mastercard.',
      amount: amount,
      publishableKey: _publishableKey,
      cardHolderName: creditModel.cardHolderName,
      cardNumber: creditModel.cardNumber,
      cvv: creditModel.cvv,
      expiryMonth: creditModel.month,
      expiryYear: creditModel.year,
      callbackUrl: 'https://example.com/orders',
    );
    CreditcardModel creditCardModel = CreditcardModel.fromJson(res.source);
    return creditCardModel;
  }

  // https://developer.apple.com/documentation/apple_pay_on_the_web
  // static Future<String?> payWithApplePay({
  //   required double amount,
  //   required String serviceName
  // }) async {
  //   final f = FlutterPay();
  //   f.setEnvironment(
  //     environment: PaymentEnvironment.Test,
  //   );
  //   final s = await f.requestPayment(
  //     paymentItems: [
  //       PaymentItem(name: serviceName, price: amount),
  //     ],
  //     currencyCode: 'SAR',
  //     countryCode: 'SA',
  //     supportedCountries: ['SA'],
  //     appleParameters: AppleParameters(merchantIdentifier: _applePayMerchantID, merchantName: 'تمهير'),
  //   );
  //   if (s.isNotEmpty) {
  //     return json.decode(s)['header']['transactionId'];
  //   }
  //   return null;
  //   // PayModel res = await _moyasarPayment.applePay(
  //   //   amount: amount,
  //   //   publishableKey: _publishableKey,
  //   //   applepayMerchantId: _applePayMerchantID,
  //   //   paymentItems: {'Service Cost' : amount, 'Total Cost': amount},
  //   //   currencyCode: 'SAR',
  //   //   countryCode: 'SA',
  //   //   description: 'Paying for a service with apple pay.',
  //   // );
  //   // if (res.type != null) {
  //   //   showSnackBar(res.message, errorMessage: true);
  //   //   return null;
  //   // } else {
  //   //   ApplePayModel applePayModel = ApplePayModel.fromJson(res.source);
  //   //   return applePayModel;
  //   // }
  // }

  // https://moyasar.com/docs/tutorials/stc-pay/
  static Future<void> payWithSTC({
    required double amount,
    required String phoneNumber,
  }) async {
    PayModel res = await _moyasarPayment.stcPay(
      amount: amount,
      phoneNumber: phoneNumber,
      publishableKey: _publishableKey,
      description: 'Paying for a service with STC.',
    );

    STCPayModel stcPayModel = STCPayModel.fromJson(res.source);
    print(stcPayModel.toJson());
  }

  static Future<void> verifySTCOTP() async {
    var resdata = await _moyasarPayment.stcPayOtp(
      otpValue: 'otp Value',
      transactionUrl: 'transaction_url',
    );
    print(resdata);
  }

}