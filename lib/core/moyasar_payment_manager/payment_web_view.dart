import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants.dart';
import '../../views/captain/payment/cubit.dart';
import '../../widgets/snack_bar.dart';
import '../router/router.dart';

class PaymentWebviewView extends StatefulWidget {
  const PaymentWebviewView({Key? key, required this.url, required this.paymentCubit}) : super(key: key);

  final PaymentCubit paymentCubit;
  final String url;
  @override
  State<PaymentWebviewView> createState() => _PaymentWebviewViewState();
}

class _PaymentWebviewViewState extends State<PaymentWebviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains('id') &&
              request.url.contains('amount') &&
              request.url.contains('status')) {
            final params = getParamFromURL(request.url);
            // status: failed, paid
            if (params['status'] == 'paid') {
              widget.paymentCubit.sendTransactionID(params['id']);
            } else {
              showSnackBar('حدث خطأ اثناء عملية الدفع !', errorMessage: true);
              RouteManager.pop();
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
