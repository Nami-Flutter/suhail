import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/commission_bank/view.dart';
import 'package:soheel_app/views/captain/wallet/cubit/cubit.dart';
import 'package:soheel_app/views/captain/wallet/cubit/states.dart';
import 'package:soheel_app/views/shared/trip_details/units/map.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit()..getWalletBalance(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل'
        ),
        body: BlocBuilder<WalletCubit,WalletStates>(
          builder: (context, state) {
            final cubit = WalletCubit.of(context);
            return state is WalletLoadingStates ? Loading() :
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',width: sizeFromWidth(3),),
                  SizedBox(height: 30,),
                  Text('الرصيد المدين :',style: TextStyle(fontSize: 30,color: kPrimaryColor),),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(cubit.account.toString(),style: TextStyle(color: kAccentColor,fontSize: 50),),
                      SizedBox(width: 20,),
                      Text('ريال',style: TextStyle(color: kAccentColor,fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  ConfirmButton(
                    onPressed:()=> RouteManager.navigateTo(commissionBankView()),
                    color: kAccentColor,
                    title: 'دفع العموله عن طريق حساب بنكي',
                  ),
                  SizedBox(height: 15,),
                  ConfirmButton(
                    color: kAccentColor,
                    onPressed: (){},
                    title: 'دفع العموله عن طريق ماستر كارد  ',
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
