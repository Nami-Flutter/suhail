import 'package:flutter/material.dart';

import '../../constants.dart';

class TripCard extends StatelessWidget {
  const TripCard({Key? key, this.image, this.status, this.truckType, required this.onTap}) : super(key: key);
  final String? image;
  final String? status;
  final String? truckType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhiteColor
        ),
        child: Row(
          children: [
            Image.asset(image.toString(),width: 80,height: 60,),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status.toString(),style: Theme.of(context).textTheme.headline6,),
                Text(truckType.toString(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kDarkGreyColor))
              ],
            )
          ],
        ),
      ),
    );

  }
}
