import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/cubit.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/states.dart';

class CCompleteRegisterView extends StatelessWidget {
  const CCompleteRegisterView({Key? key, required this.telephone}) : super(key: key);
  final String telephone;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CCompleteRegisterCubit(telephone:telephone)..getCategories(),
      child: BlocBuilder<CCompleteRegisterCubit,CCompleteRegisterStates>(
        builder: (context, state) {
          final cubit = CCompleteRegisterCubit.of(context);
          return cubit.getCurrentView;
        },
      ),

    );
  }
}
