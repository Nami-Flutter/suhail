// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:soheel_app/widgets/drawer.dart';
//
// import '../../../constants.dart';
// import '../../../core/router/router.dart';
// import '../../../widgets/app_bar.dart';
// import '../requset_trip/view.dart';
//
// class SubCategoryView extends StatelessWidget {
//   const SubCategoryView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       appBar: appBar(
//         title: 'سـهـيـل',
//         centerTitle: true,
//       ),
//       drawer: drawer(),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
//             child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Text('حدد حجم الشاحنة المطلوبة : ',style: Theme.of(context).textTheme.headline6,)),
//           ),
//          ListView.builder(
//            itemBuilder:(context, index) {
//            return  Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: MaterialButton(
//                focusColor: kPrimaryColor,
//                elevation: 0.0,
//                splashColor: kPrimaryColor,
//                hoverColor: kPrimaryColor,
//                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
//                color: kWhiteColor,
//                onPressed: (){
//                  RouteManager.navigateTo(RequestTripView());
//                },
//                child: Container(
//                  margin: EdgeInsets.symmetric(horizontal: 20),
//                  color: kWhiteColor,
//                  width: double.infinity,
//                  child: Row(
//                    children: [
//                      Image.asset('assets/images/truck-1.png',width: sizeFromWidth(3),height: sizeFromHeight(6),),
//                      Spacer(),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 30),
//                        child: Text('متوسطه',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kBlueColor),),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            );
//          },
//          scrollDirection: Axis.vertical,
//          physics: BouncingScrollPhysics(),
//          itemCount: 3,
//          shrinkWrap: true,
//          )
//         ],
//       ),
//     );
//
//   }
// }
