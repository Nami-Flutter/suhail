import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/captain/commission_bank/cubit/cubit.dart';
import 'package:soheel_app/views/captain/commission_bank/cubit/states.dart';
import 'package:soheel_app/widgets/app/BankExpansionCard.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

class commissionBankView extends StatefulWidget {
  const commissionBankView({Key? key}) : super(key: key);

  @override
  _commissionBankViewState createState() => _commissionBankViewState();
}

class _commissionBankViewState extends State<commissionBankView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BankCubit()..AllBankList(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل'
        ),
        body: BlocBuilder<BankCubit,BankStates>(
          builder: (context, state) {
            final cubit = BankCubit.of(context);
            final bankData = cubit.bankModel?.banks;
            if(state is BankLoadingStates){
              return Loading();
            }
            return bankData == null ? Center(child: Text('لا توجد بنوك مضافه')) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BankExpansionCard(
                      title: bankData[index].bankName!,
                      bankAccountName: bankData[index].bankAccountName!,
                      accountNumber: bankData[index].bankAccountNum!,
                      bankIban: bankData[index].bankIpan!,
                    ),
                    itemCount: bankData.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('بينات التحويل : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                  ),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFormField(
                          hint: ' اسم الراسل',
                          verticalMargin: 10,
                          validator: Validator.name,
                          isNext: true,
                          onSave: (v)=> cubit.senderName = v,
                        ),
                        InputFormField(
                          hint: 'اسم البنك المرسل منه',
                          verticalMargin: 10,
                          validator: Validator.name,
                          isNext: true,
                          onSave: (v)=> cubit.sendingBank = v,
                        ),
                        InputFormField(
                          hint: 'اسم البنك المرسل اليه',
                          verticalMargin: 10,
                          validator: Validator.name,
                          onSave: (v)=> cubit.receivingBank = v,
                          isNext: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('  ارفق صوره التحويل : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                        ),
                        Wrap(
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      children: [
                        ...cubit.imageFileList.map((e) => Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(e.path),
                                    fit: BoxFit.cover,
                                    width: sizeFromWidth(3.5),
                                    height: 100,
                                  )),
                            ),
                            Positioned(
                              child: IconButton(
                                onPressed: () {
                                  cubit.imageFileList.remove(e);
                                  setState(() {});
                                },
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  color: kRedColor,
                                  size: 16,
                                ),
                              ),),
                          ],
                        ))
                            .toList(),
                        if (cubit.imageFileList.length < 2)
                          cubit.imageFileList.isEmpty ?  MaterialButton(
                            onPressed: () {
                              cubit.selectImages();
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kWhiteColor),
                              child: Icon(
                                FontAwesomeIcons.camera,
                                color: kDarkGreyColor,
                              ),
                            ),
                          ) : MaterialButton(
                            onPressed: cubit.selectImages,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kWhiteColor),
                              child: Icon(
                                FontAwesomeIcons.camera,
                                color: kDarkGreyColor,
                              ),
                            ),)
                      ],
                    ),
                        ConfirmButton(
                          title: 'ارسال',
                          onPressed:(){
                            cubit.transferAccountBank();
                          } ,
                          color: kPrimaryColor,
                        )
                      ],
                    ),)
                ],
              ),
            );

          },
        ),
      ),
    );
  }
}
