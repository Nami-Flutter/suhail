import 'package:flutter/material.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/wallet/view.dart';
import 'package:soheel_app/views/shared/trip_details/view.dart';
import 'package:soheel_app/views/shared/trips/view.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

import '../../../../core/app_storage/app_storage.dart';

Future showFinishedTripDialog({
  required String title,
  required String body,
  required String cost,
  required String distance,
  required String tripID,
}) {
  return showDialog(
    context: RouteManager.currentContext,
    barrierDismissible: false,
    builder: (context) => _Dialog(
      title: title,
      body: body,
      cost: cost,
      distance: distance,
      tripID: tripID,
    ),
  );
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    Key? key,
    required this.title,
    required this.body,
    required this.cost,
    required this.distance,
    required this.tripID,
  }) : super(key: key);

  final String title;
  final String body;
  final String cost;
  final String distance;
  final String tripID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عدد الكيلومتر',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  '$distance',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المبلغ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  '$cost',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              return ConfirmButton(
                title: 'متابعة',
                onPressed: () {
                  RouteManager.navigateAndPopUntilFirstPage(
                    AppStorage.customerGroup == 2
                        ? WalletView()
                        : tripID.isNotEmpty
                            ? TripDetailsView(tripId: tripID)
                            : TripsView(),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
