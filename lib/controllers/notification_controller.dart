import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chetneak_v2/main.dart';

class NotifcationController extends GetxController {
  @override
  void onInit() {
    // listenNotication();
    super.onInit();
  }

  asKUserPersionForNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings.authorizationStatus;
  }

  void localNotication() {
    var dsc = "so much update";
    flutterLocalNotificationsPlugin.show(
        0,
        "My Notication",
        "How is going?",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            dsc,
            playSound: true,
            icon: '@mipmap/ic_launcher',
            // other properties...
          ),
        ));
  }

  listenNotication() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                'incoming',
                playSound: true,
                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });
  }
}
