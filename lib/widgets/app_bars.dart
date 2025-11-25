import 'package:flutter/material.dart';

class EasyAppBar {
  static PreferredSizeWidget simple({
    required String title,
    List<Widget>? actions,
    bool centerTitle = true,
    bool showBack = true,
  }) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 0,
      leading: showBack ? const BackButton() : null,
      actions: actions,
    );
  }
}
