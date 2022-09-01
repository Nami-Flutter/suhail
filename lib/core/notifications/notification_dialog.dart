import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soheel_app/views/captain/wallet/view.dart';
import 'package:soheel_app/views/shared/trip_details/view.dart';
import 'package:soheel_app/views/shared/trips/view.dart';

import '../../constants.dart';
import '../../views/user/requset_trip/cubit/cubit.dart';
import '../../widgets/my_text.dart';
import '../router/router.dart';

bool _isNotificationDialogVisible = false;

showNotificationDialog({
  required String title,
  required String body,
  required String type,
  required String? tripID,
}) {
  if (AddTripCubit.isTimerDialogOpen) {
    AddTripCubit.isTimerDialogOpen = false;
    RouteManager.pop();
  }
  if (_isNotificationDialogVisible) {
    RouteManager.pop();
  }
  _isNotificationDialogVisible = true;
  showCupertinoDialog(
    context: RouteManager.currentContext,
    barrierDismissible: false,
    builder: (context) => _Dialog(title, body, type, tripID),
  );
}

class _Dialog extends StatelessWidget {
  final String title, body, type;
  final String? tripID;
  _Dialog(this.title,this.body, this.type, this.tripID);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CupertinoAlertDialog(
          title: MyText(
            title: title,
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          content: MyText(
            title: body,
            color: kBlackColor,
            fontSize: 14,
          ),
          actions: [
            CupertinoButton(
              child: MyText(
                title: 'الغاء',
                color: Colors.red,
              ),
              onPressed: () {
                _isNotificationDialogVisible = false;
                RouteManager.pop();
              },
            ),
            CupertinoButton(
              child: MyText(
                title: 'متابعة',
                color: kPrimaryColor,
              ),
              onPressed: () {
                _isNotificationDialogVisible = false;
                if (type == 'wallet') {
                  RouteManager.navigateAndPopUntilFirstPage(WalletView());
                } else {
                  RouteManager.navigateAndPopUntilFirstPage(tripID == null ? TripsView() : TripDetailsView(tripId: tripID));
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
