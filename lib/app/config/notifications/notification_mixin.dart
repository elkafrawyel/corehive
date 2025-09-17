import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// A mixin to handle FCM notifications for foreground, background, and terminated states
mixin FCMNotificationMixin<T extends StatefulWidget> on State<T> {
  late final StreamSubscription<RemoteMessage> _foregroundSubscription;

  @override
  void initState() {
    super.initState();

    // Foreground notifications
    _foregroundSubscription = FirebaseMessaging.onMessage.listen(_handleNotification);

    // Background notifications (app opened via notification)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

    // Check for terminated state notifications
    _checkTerminatedNotification();
  }

  @override
  void dispose() {
    _foregroundSubscription.cancel();
    super.dispose();
  }

  /// Called for any incoming notification
  void onNotify(RemoteMessage notification);

  void _handleNotification(RemoteMessage notification) {
    if (!mounted) return;
    onNotify(notification);
  }

  /// Checks if the app was opened from a terminated state via notification
  Future<void> _checkTerminatedNotification() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotification(initialMessage);
    }
  }
}
