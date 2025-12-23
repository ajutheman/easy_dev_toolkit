// lib/network/offline_screen.dart
import 'package:flutter/material.dart';
import 'connectivity_service.dart';

class OfflineScreen extends StatelessWidget {
  final Widget child;

  const OfflineScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService.statusStream,
      builder: (context, snapshot) {
        final connected = snapshot.data ?? ConnectivityService.isConnected;

        if (connected) return child;

        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 40, color: Colors.grey),
                SizedBox(height: 16),
                Text("No Internet Connection", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}
