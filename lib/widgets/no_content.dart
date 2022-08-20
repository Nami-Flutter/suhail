// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import '../constants.dart';
//
// class NoContent extends StatelessWidget {
//   final String? title;
//   final VoidCallback? onTap;
//
//   NoContent({this.title, this.onTap});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset(getLottie('empty_box')),
//               SizedBox(height: 20,),
//               Text(title ?? "لا توجد عناصر!",textAlign: TextAlign.center,style: TextStyle(
//                 color: kAccentColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),),
//               // if(subtitle != null && onSubtitlePressed != null)
//               //   TextButton(onPressed: ()=> onSubtitlePressed!(), child: Text(subtitle!,style: TextStyle(color: kPrimaryColor),)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }