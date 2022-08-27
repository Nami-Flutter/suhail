// import 'package:elazel_elshafaaf/core/router/router.dart';
// import 'package:elazel_elshafaaf/features/navBar/presentation/view.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class FlutterLocalNotificationHelper{
//
//   static late AndroidInitializationSettings _initializationSettingsAndroid;
//   static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   static late IOSInitializationSettings _initializationSettingsIOS;
//   static late InitializationSettings _initializationSettings;
//
//   static init(){
//     _initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     _initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
//     _initializationSettings = InitializationSettings(android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _flutterLocalNotificationsPlugin.initialize(_initializationSettings,onSelectNotification: _onSelectNotification);
//   }
//
//   static Future _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}
//
//   static Future<void> showNotification({String title = 'Title',String body= 'Body',String payload = 'Payload'})async{
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.max, priority: Priority.high, showWhen: false,playSound: false,);
//     const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(presentSound: false,presentAlert: true,presentBadge: true);
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iosNotificationDetails);
//     try{
//       await _flutterLocalNotificationsPlugin.show(
//           0, title, body, platformChannelSpecifics,
//           payload: 'item x');
//     }catch(e){}
//   }
//
//   static Future _onSelectNotification(String? payload) async {
//     MagicRouter.navigateAndPopAll(NavBarView(initialIndex: 3));
//   }
// }
//
// /*
// <intent-filter>
//                 <action android:name="FLUTTER_NOTIFICATION_CLICK" />
//                 <category android:name="android.intent.category.DEFAULT" />
//             </intent-filter>
//  */