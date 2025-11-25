// import 'package:easy_dev_toolkit/widgets/buttons/buttons/adaptive_button.dart';
import 'package:flutter/material.dart';
import '../core/responsive_extensions.dart';
import 'connectivity_service.dart';
import '../widgets/buttons/adaptive_button.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineScreen({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService.statusStream,
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? true;

        if (isOnline) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 60),
              SizedBox(height: 16.h),
              Text(
                'You are offline',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please check your internet connection.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              AdaptiveButton(text: 'Retry', onPressed: onRetry ?? () {}),
            ],
          ),
        );
      },
    );
  }
}
