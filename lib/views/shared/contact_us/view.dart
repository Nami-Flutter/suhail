import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/validator/validation.dart';
import 'package:soheel_app/views/shared/contact_us/cubit/cubit.dart';
import 'package:soheel_app/views/shared/contact_us/cubit/states.dart';
import 'package:soheel_app/widgets/app/empty.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/confirm_button.dart';
import 'package:soheel_app/widgets/drawer.dart';
import 'package:soheel_app/widgets/text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit()..getContactData(),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل',
          centerTitle: true,
        ),
        drawer: drawer(),
        body: BlocBuilder<ContactUsCubit,ContactUsStates>(
          builder: (context, state) {
            final cubit = ContactUsCubit.of(context);
            final contactData = cubit.contactInfoModel;
            if(contactData == null){
              return Loading();
            }else return
            RefreshIndicator(
              onRefresh: ContactUsCubit.of(context).getContactData,
              backgroundColor: kPrimaryColor,
              color: kWhiteColor,
              displacement: 50.0,
              strokeWidth: 3.0,
              edgeOffset: 0.0,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.headset,size: 100,color: kGreyColor,),
                        SizedBox(height: 20,),
                        Text('الخط الساخن',style: TextStyle(color: kPrimaryColor,fontSize: 22),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => launchUrl(Uri.parse('tel:' + contactData.telephone!)),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(child: Text(contactData.telephone.toString(),style: TextStyle(color: kDarkGreyColor,fontSize: 22),)),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: kDarkGreyColor
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: kGreyColor
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          width: 150,
                          color: kPrimaryColor,
                        ),
                        Text('أو',style: TextStyle(fontSize: 20),),
                        Container(
                          height: 1,
                          width: 150,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        InputFormField(
                          hint: "الاسم",
                          horizontalMargin: 20,
                          fillColor: kWhiteColor,
                          verticalMargin: 5,
                        ),
                        InputFormField(
                          hint: 'رقم الجوال',
                          horizontalMargin: 20,
                          verticalMargin: 5,
                          fillColor: kWhiteColor,
                          maxLength: 10,
                        ),
                        InputFormField(
                          hint: '  الرسالة  ',
                          fillColor: kWhiteColor,
                          horizontalMargin: 20,
                          verticalMargin: 5,
                          validator: Validator.enquiry,
                          onSave: (v)=> cubit.enquiry = v,
                          maxLines: 6,
                        ),
                        SizedBox(height: 50,),
                        BlocBuilder<ContactUsCubit,ContactUsStates>(
                          builder: (context, state) {
                            return state is ContactUsLoadingState ? Loading() :
                            ConfirmButton(
                              verticalMargin: 20,
                              onPressed: cubit.contactUs,
                              horizontalMargin: 20,
                              title: '  ارسال',
                              color: kPrimaryColor,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
