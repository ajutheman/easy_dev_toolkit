import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyLoader {
  static Widget adaptive({double size = 24}) {
    return Center(child: _platformLoader(size: size));
  }

  static Widget _platformLoader({double size = 24}) {
    return Builder(
      builder: (context) {
        final platform = Theme.of(context).platform;

        if (platform == TargetPlatform.iOS ||
            platform == TargetPlatform.macOS) {
          return SizedBox(
            width: size,
            height: size,
            child: const CupertinoActivityIndicator(),
          );
        }

        return SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
    );
  }
}
