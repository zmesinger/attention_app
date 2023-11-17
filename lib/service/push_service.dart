
import 'package:attention_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  handleMessage(RemoteMessage? message) {
    if(message == null) {
      return;
    }

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );

  }

   Future initPushNotifications() async {
    _fcm.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
   }

  Future<String?> getToken() async {
    await _fcm.requestPermission();
    String? token = await _fcm.getToken();
    print('Token: $token');
    initPushNotifications();
    return token;
  }


}
