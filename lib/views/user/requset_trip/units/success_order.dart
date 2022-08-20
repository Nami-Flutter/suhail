import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/shared/trip_details/view.dart';
import 'package:soheel_app/views/user/home/view.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/cubit.dart';
import 'package:soheel_app/widgets/snack_bar.dart';

import '../../../../constants.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../shared/trips/view.dart';

Widget successOrder(String tripID){
  return _Dialog(tripId: tripID,);
}

class _Dialog extends StatefulWidget {
  const _Dialog({Key? key, required this.tripId}) : super(key: key);
  final String tripId;
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {

  Timer? timer;
  int counter = 10;


  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds:1), (timer) async {
      counter--;
      setState(() {});
      if (counter == 1) {
        timer.cancel();
        final success = await AddTripCubit(null).cancelTrip(widget.tripId);
        if (success) {
          RouteManager.pop();
          showSnackBar('لم يتم العثور علي كابتن', errorMessage: true);
        } else {
          RouteManager.navigateAndPopUntilFirstPage(TripDetailsView(tripId: widget.tripId));
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('جاري البحث عن كابتن برجاء الانتظار'),
      content: Text(
        '$counter',
        style: TextStyle(color: kPrimaryColor, fontSize: 40, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: [
        ConfirmButton(
          title: 'الغاء الرحلة',
          onPressed: () async {
            final success = await AddTripCubit(null).cancelTrip(widget.tripId);
            if (success) {
              RouteManager.pop();
              showSnackBar('تم الغاء الرحلة', errorMessage: true);
            }
          },
        )
      ],
    );
  }
}