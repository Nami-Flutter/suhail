import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/router/router.dart';
import 'package:soheel_app/views/captain/commission_bank/view.dart';
import 'package:soheel_app/views/captain/payment/view.dart';
import 'package:soheel_app/views/captain/wallet/cubit.dart';
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
        appBar: appBar(title: 'المحفظة'),
        body: BlocBuilder<WalletCubit, WalletStates>(
          builder: (context, state) {
            final cubit = WalletCubit.of(context);
            if (state is WalletLoading) {
              return Center(
                child: Loading(),
              );
            } else if (cubit.balance == null) {
              return Center(
                child: TextButton(
                  onPressed: cubit.getWalletBalance,
                  child: Text('فضل تحميل المحفظة, اعادة المحاولة'),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      getAsset('logo'),
                      height: 150,
                    ),
                    SizedBox(height: 15),
                    Text('الرصيد المدين',style: TextStyle(fontSize: 30,color: kPrimaryColor),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cubit.balance == '0' ? '0' : '-${cubit.balance}',style: TextStyle(color: kAccentColor,fontSize: 50),),
                        SizedBox(width: 5),
                        Text('ريال',style: TextStyle(color: kAccentColor,fontSize: 20),),
                      ],
                    ),
                    ConfirmButton(
                      onPressed:() => RouteManager.navigateTo(CommissionBankView()),
                      title: 'دفع العمولة عن طريق حساب بنكي',
                    ),
                    SizedBox(height: 15,),
                    ConfirmButton(
                      border: true,
                      onPressed: () async => RouteManager.navigateTo(PaymentView(
                        amount: double.parse(cubit.balance!),
                      )),
                      title: 'دفع العمولة عن طريق ماستر كارد او فيزا',
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
