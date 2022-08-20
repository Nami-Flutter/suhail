import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/cubit.dart';

import '../../../../constants.dart';
import '../../../../widgets/confirm_button.dart';
import '../../../../widgets/text_form_field.dart';

class DetailsFields extends StatelessWidget {
  const DetailsFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTripCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('التفاصيل',style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor),),
                Text('قم بادخال تفاصيل للطلب او توجيهات للكابتن',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor),),
              ],
            )
        ),
        InputFormField(
          maxLines: 5,
          fillColor: kWhiteColor,
          horizontalMargin: 20,
          controller: cubit.detailsController,
        ),
      ],
    );
  }

}
