import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibration/vibration.dart';

/// Rest-timer completion feedback: haptics + an audible/local notification
/// so the timer works even when the user glances away. The bloc calls
/// [onRestComplete] exactly when a countdown reaches zero naturally
/// (not on skip/adjust).
class RestFeedbackService {
  RestFeedbackService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(
          android: android, iOS: darwin, macOS: darwin),
    );
    _initialized = true;
  }

  Future<void> onRestComplete() async {
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: 400);
    }
    await _plugin.show(
      id: 1001,
      title: 'Rest over',
      body: 'Back under the bar — next set.',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'rest_timer',
          'Rest timer',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
  }
}
