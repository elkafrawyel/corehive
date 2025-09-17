import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

import '../helpers/logging_helper.dart';


class NotificationsService {
  static const String _channelId = 'com.corehive_store.app';
  static const String _channelName = 'corehive_store Notifications';
  static const String _channelDescription = 'Notifications for corehive_store app';

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
    );

    _firebaseMessaging.getToken().then(
          (token) => AppLogger.log('📱 FIREBASE TOKEN: $token'),
    );

    _firebaseMessaging.getAPNSToken().then((token) {
      AppLogger.log("📱 APNs token: $token");
    });

    // Handle terminated notification
    _firebaseMessaging.getInitialMessage().then(_handleInitialMessage);

    // Handle background notification taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null) return notification.apple?.imageUrl;
    if (Platform.isAndroid && notification.android != null) return notification.android?.imageUrl;
    return null;
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';
    final Response response = await Dio(
      BaseOptions(responseType: ResponseType.bytes, followRedirects: false),
    ).get(url);
    final file = File(path);
    await file.writeAsBytes(response.data);
    return path;
  }

  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
    String? imageUrl,
  }) async {
    BigPictureStyleInformation? bigPicture;
    if (imageUrl != null) {
      final imagePath = await _downloadAndSaveFile(
          imageUrl, 'notification_${DateTime.now().millisecondsSinceEpoch}.png');
      bigPicture = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
        hideExpandedLargeIcon: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true,
      );
    }

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      styleInformation: bigPicture,
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void _handleInitialMessage(RemoteMessage? message) {
    if (message != null) {
      AppLogger.log("🔔 Initial Notification: ${message.notification?.title}");
      _handleBackgroundMessage(message);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    AppLogger.log("🔔 Background Notification Tapped.");
    final payload = jsonEncode(message.data);
    // Handle navigation or other actions here
  }

  void _handleForegroundMessage(RemoteMessage message) {
    AppLogger.log("🔔 Foreground Notification: ${message.notification?.title}");
    if (message.notification != null) {
      final payload = jsonEncode(message.data);
      final imageUrl = _getImageUrl(message.notification!);
      showSimpleNotification(
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        payload: payload,
        imageUrl: imageUrl,
      );
    }
  }

  static void _onNotificationTap(NotificationResponse response) {
    AppLogger.log('🔔 Notification tapped.');
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      AppLogger.log(data.toString());
      // Navigate dynamically based on payload if needed
    }
  }
}
