import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {
  const WebviewView({Key? key, required this.url}) : super(key: key);

  final String url;
  @override
  State<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        // navigationDelegate: (NavigationRequest request) {
        //   if (request.url.contains('id') &&
        //       request.url.contains('amount') &&
        //       request.url.contains('status')) {
        //     final params = getParamFromURL(request.url);
        //     // status: failed, paid
        //     if (params['status'] == 'paid') {
        //       cubit.order(params['id']);
        //     } else {
        //       showSnackBar('حدث خطأ اثناء عملية الدفع !', errorMessage: true);
        //       RouteManager.pop();
        //     }
        //     return NavigationDecision.prevent;
        //   }
        //   return NavigationDecision.navigate;
        // },
      ),
    );
  }
}
