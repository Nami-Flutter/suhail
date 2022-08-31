import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
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
    FirebaseMessaging.onMessage.listen((event) {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        ios: IosSounds.glass,
        looping: false,
      );
      showNotificationDialog(
        title: event.notification?.title ?? '',
        body: event.notification?.body ?? '',
        tripID: event.data['trip_id'],
        type: event.data['type'],
      );
    });
  }

  static void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // RouteManager.navigateAndPopUntilFirstPage(TamidDetailsView(title: event.notification?.title ?? '', id: event.data['tamid_id']));
    });
  }

  static void checkIfUserClickedNotificationFromBackground() async {
    final notification = await _firebaseMessaging.getInitialMessage();
    if (notification == null) {
      return;
    }
    showNotificationDialog(
      title: notification.notification?.title ?? '',
      body: notification.notification?.body ?? '',
      tripID: notification.data['trip_id'],
      type: notification.data['type'],
    );
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

}