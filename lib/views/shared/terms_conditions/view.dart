import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/widgets/app/loading.dart';

import '../../../widgets/app_bar.dart';
import '../../../widgets/drawer.dart';
import 'cubit.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TermsCubit()..getTerms(id: id),
      child: Scaffold(
        appBar: appBar(
          title: 'سهيل',
          centerTitle: true,
        ),
        body: BlocBuilder<TermsCubit, TermsStates>(
          builder: (context, state) {
            final cubit = TermsCubit.of(context);
            if (state is TermsLoading) {
              return Loading();
            }
            final title = cubit.termsModel?.title ?? '';
            final desc = cubit.termsModel?.description ?? '';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset('assets/images/logo.png'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(title,style: TextStyle(color: kPrimaryColor,fontSize: 24),),
                ),
                Expanded(
                    flex: 5,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(desc,
                            style: TextStyle(color: kDarkGreyColor,fontSize: 16),),
                        ),
                      ],
                    )
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
