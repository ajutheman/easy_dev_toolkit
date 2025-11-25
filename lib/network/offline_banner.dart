import 'package:flutter/material.dart';
import 'connectivity_service.dart';

class OfflineBanner extends StatelessWidget {
  final String message;

  const OfflineBanner({super.key, this.message = 'No Internet Connection'});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService.statusStream,
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? true;

        if (isOnline) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.wifi_off, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'No Internet Connection',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
