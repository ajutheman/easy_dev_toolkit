// import 'package:easy_dev_toolkit/widgets/buttons/buttons/adaptive_button.dart'
// show AdaptiveButton;
import 'package:flutter/material.dart';
import '../core/responsive_extensions.dart';
import '../widgets/buttons/adaptive_button.dart';

class RetryWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RetryWidget({
    super.key,
    this.message = 'Something went wrong',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 16.h),
          AdaptiveButton(text: 'Retry', onPressed: onRetry),
        ],
      ),
    );
  }
}
