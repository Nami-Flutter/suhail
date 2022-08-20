import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/widgets/app/BankExpansionCard.dart';
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
    return Scaffold(
      appBar: appBar(
        title: 'سهيل'
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BankExpansionCard(
                title: 'البنك الاهلي',
                bankAccountName: 'Mohamed Ahmed',
                accountNumber: '547522369800',
                bankIban: '24545455454',
              ),
              BankExpansionCard(
                title: 'البنك الاهلي',
                bankAccountName: 'Mohamed Ahmed',
                accountNumber: '547522369800',
                bankIban: '24545455454',
              ),
              BankExpansionCard(
                title: 'البنك الاهلي',
                bankAccountName: 'Mohamed Ahmed',
                accountNumber: '547522369800',
                bankIban: '24545455454',
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('بينات التحويل : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 InputFormField(
                   hint: 'اسم البنك المرسل منه',
                   verticalMargin: 10,
                   onPressed: (){},
                   isNext: true,
                 ),
                 InputFormField(
                    hint: 'اسم البنك المرسل منه',
                    verticalMargin: 10,
                    onPressed: (){},
                    isNext: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('  ارفق صوره التحويل : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                  ),
                  MaterialButton(
                      onPressed: () {},
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
                    ),
                  ConfirmButton(
                    title: 'ارسال',
                    onPressed: (){},
                    color: kPrimaryColor,
                  )
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
