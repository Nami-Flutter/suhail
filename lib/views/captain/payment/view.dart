import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../constants.dart';
import '../../../core/validator/validation.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/confirm_button.dart';
import '../../../widgets/my_text.dart';
import '../../../widgets/text_form_field.dart';
import 'cubit.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key, required this.amount}) : super(key: key);

  final double amount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(amount: amount),
      child: BlocBuilder<PaymentCubit, PaymentStates>(
        builder: (context, state) {
          final cubit = PaymentCubit.of(context);
          return Scaffold(
            appBar: appBar(title: 'الدفع'),
            body: Form(
              key: cubit.formKey,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Image.asset(
                    getAsset('logo'),
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  MyText(
                    title: "الاجمالي" + " : $amount " + "S.R",
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: 15),
                  InputFormField(
                    upperText: "رقم البطاقة",
                    isNumber: true,
                    maxLength: 16,
                    onSave: (v) => cubit.cardNumber = v,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'حقل فارغ !';
                      } else if (v.length != 16) {
                        return 'رقم البطاقة يجب ان يتكون من ١٦ رقم !';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputFormField(
                            upperText: "الشهر",
                            isNumber: true,
                            maxLength: 2,
                            onSave: (v) => cubit.month = v,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'حقل فارغ !';
                              } else if (v.length < 2) {
                                return 'مثال : 02';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InputFormField(
                            upperText: "السنة",
                            isNumber: true,
                            maxLength: 2,
                            onSave: (v) => cubit.year = v,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'حقل فارغ !';
                              } else if (v.length < 2) {
                                return 'مثال : 22';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InputFormField(
                            upperText: "رمز الآمان",
                            isNumber: true,
                            maxLength: 3,
                            onSave: (v) => cubit.cvv = v,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'حقل فارغ !';
                              } else if (v.length < 2) {
                                return 'مثال : 123';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  InputFormField(
                    upperText: "اسم حامل البطاقة",
                    isNext: false,
                    onSave: (v) => cubit.cardHolderName = v,
                    validator: Validator.name,
                  ),
                  state is PaymentLoading ? Loading() : ConfirmButton(
                    title: "الدفع",
                    verticalMargin: 40,
                    onPressed: cubit.pay,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}