// import 'package:elazel_elshafaaf/core/notifications/local_notifications.dart';
// import 'package:elazel_elshafaaf/core/router/router.dart';
// import 'package:elazel_elshafaaf/features/navBar/presentation/view.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebaseLocalNotification {
//
//   static void onClick() async {
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       MagicRouter.navigateAndPopAll(NavBarView(initialIndex: 3));
//     });
//     FirebaseMessaging.instance.getInitialMessage().then((value) {
//       if(value != null)
//         Future.delayed(Duration(seconds: 4), ()=> MagicRouter.navigateAndPopAll(NavBarView(initialIndex: 3)));
//     });
//   }
//
//   static void onMessage() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       // try{
//       //   FlutterRingtonePlayer.playNotification();
//         final notification = event.notification!;
//         // final data = event.data;
//         FlutterLocalNotificationHelper.showNotification(
//           title: notification.title!,
//           body: notification.body!,
//         );
//       //   showNotificationDialog(notification.title!, notification.body!, ()=> onPressed(data));
//       // }catch(e){
//       //   showToast(e.toString(), color: Colors.red);
//       // }
//     });
//   }
//
//   static Future<void> init () async {
//     final isSupported = FirebaseMessaging.instance.isSupported();
//     if(!isSupported) return;
//     onClick();
//     onMessage();
//   }
//
//   // static void onPressed(Map<String, dynamic> data){
//   //   MagicRouter.navigateAndPopAll(NavBarView(initialIndex: 3));
//   // }
//
//   // static void listen()=> _firebaseMessaging.configure(
//   //   onMessage: (map) async {
//   //     FlutterRingtonePlayer.play(android: AndroidSounds.notification,ios: IosSounds.glass);
//   //     final title = await map['notification']['title'];
//   //     final body = await map['notification']['body'];
//   //     FlutterLocalNotificationHelper.showNotification(title: title,body: body);
//   //     // showCupertinoDialog(context: MagicRouter.currentContext,
//   //     //   barrierDismissible: false,
//   //     //   builder: (context) => CupertinoAlertDialog(
//   //     //     content: Column(
//   //     //       crossAxisAlignment: CrossAxisAlignment.stretch,
//   //     //       children: [
//   //     //         Text(
//   //     //           title,
//   //     //           textAlign: TextAlign.center,
//   //     //           style: getTextTheme(context).title.copyWith(fontSize: 20),
//   //     //         ),
//   //     //         SizedBox(height: 10,),
//   //     //         Text(
//   //     //           body,
//   //     //           textAlign: TextAlign.center,
//   //     //           overflow: TextOverflow.fade,
//   //     //           style: getTextTheme(context).subtitle.copyWith(color: kPrimaryColor,fontSize: 16),
//   //     //         ),
//   //     //         Row(
//   //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     //           children: [
//   //     //             ConfirmButton(
//   //     //               verticalMargin: 10,
//   //     //               title: loggedUser.languageId == '1' ? 'Continue' : 'متابعة',
//   //     //               onPressed: () => MagicRouter.navigateAndPopAll(HomeView()),
//   //     //             ),
//   //     //             ConfirmButton(
//   //     //               verticalMargin: 10,
//   //     //               title: 'إالغاء',
//   //     //               color: Colors.red,
//   //     //               onPressed: () => MagicRouter.pop(),
//   //     //             ),
//   //     //           ],
//   //     //         ),
//   //     //       ],
//   //     //     ),
//   //     //   ),);
//   //   },
//   // );
// }