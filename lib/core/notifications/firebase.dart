import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:soheel_app/views/shared/trip_details/units/finished_trip_dialog.dart';
import '../app_storage/app_storage.dart';
import '../dio_manager/dio_manager.dart';
import 'notification_dialog.dart';

class FirebaseMessagingHelper {

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static void init() {
    onMessage();
    onMessageOpenedApp();
    checkIfUserClickedNotificationFromBackground();
  }

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((notification) {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: IosSounds.glass,
        looping: false,
      );
      _handleNotificationReceiver(notification);
    });
  }

  static void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      _handleNotificationReceiver(notification);
    });
  }

  static void checkIfUserClickedNotificationFromBackground() async {
    final notification = await _firebaseMessaging.getInitialMessage();
    if (notification == null) {
      return;
    }
    _handleNotificationReceiver(notification);
    // RouteManager.navigateAndPopUntilFirstPage(TamidDetailsView(title: notification.notification?.title ?? '', id: notification.data['tamid_id']));
  }

  static Future<void> sendFCMToServer()async{
    if (Platform.isIOS)
      await _firebaseMessaging.requestPermission();
    String? fcm = await getFCM();
    final body = {
      'token': fcm,
      'customer_id': AppStorage.customerID,
    };
    await DioHelper.post('token', data: body);
  }

  static Future<String?> getFCM()async{
    try {
      final fcm = await _firebaseMessaging.getToken();
      return fcm;
    } catch (_) {
      return '';
    }
  }

  static Future<void> _handleNotificationReceiver(RemoteMessage notification) async {
    if (notification.data['type'] == 'finished trip') {
      showFinishedTripDialog(
        title: notification.notification?.title ?? '',
        tripID: notification.data['trip_id'] ?? '',
        body: notification.notification?.body ?? '',
        cost: notification.data['trip_cost'] ?? '',
        distance: notification.data['trip_distance'] ?? '',
      );
    } else {
      showNotificationDialog(
        title: notification.notification?.title ?? '',
        body: notification.notification?.body ?? '',
        tripID: notification.data['trip_id'] ?? '',
        type: notification.data['type'] ?? '',
      );
    }
  }

}