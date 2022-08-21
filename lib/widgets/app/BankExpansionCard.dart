
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/widgets/my_text.dart';

class BankExpansionCard extends StatefulWidget {
  final String title;
  final String accountNumber;
  final String bankAccountName;
  final String bankIban;

  const BankExpansionCard({required this.title, required this.accountNumber, required this.bankAccountName, required this.bankIban});
  @override
  _BankExpansionCardState createState() => _BankExpansionCardState();
}

class _BankExpansionCardState extends State<BankExpansionCard> {

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: isCollapsed ? 50 : 160,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInBack,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: widget.title,fontSize: 18,color: kPrimaryColor,),
                  Icon(
                    isCollapsed ? FontAwesomeIcons.angleDown : FontAwesomeIcons.angleUp,
                    color: isCollapsed ? kPrimaryColor : kPrimaryColor,
                    size: 22,)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: MyText(title: widget.bankAccountName,fontSize: 18,color: Color(0XFF464646)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: MyText(title: widget.bankIban,fontSize: 16,color: Color(0XFF464646),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: MyText(title: widget.accountNumber,fontSize: 16,color: Color(0XFF464646),),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Color(0XFFE7EBF6),
        ),
      ),
    );
  }
}