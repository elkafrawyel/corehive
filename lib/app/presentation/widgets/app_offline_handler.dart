import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'app_data_state/app_disconnect_view.dart';

class AppOfflineHandler extends StatefulWidget {
  final Widget child;

  const AppOfflineHandler({super.key, required this.child});

  @override
  State<AppOfflineHandler> createState() => _AppOfflineHandlerState();
}

class _AppOfflineHandlerState extends State<AppOfflineHandler> {
  bool isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void initState() {
    super.initState();

    // Initial check
    _checkConnection();

    // Listen for future changes
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = result.first != ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result.first != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnected ? widget.child : const AppDisconnectView(),
    );
  }
}
