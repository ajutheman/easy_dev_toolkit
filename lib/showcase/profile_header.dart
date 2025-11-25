// import 'package:easy_dev_toolkit/widgets/buttons/buttons/adaptive_button.dart';
import 'package:flutter/material.dart';
import '../core/responsive_extensions.dart';
import '../widgets/buttons/adaptive_button.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 40.w, backgroundImage: NetworkImage(avatar)),
        SizedBox(height: 12.h),
        Text(
          name,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.h),
        Text(
          email,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 20.h),
        AdaptiveButton(text: "Edit Profile", onPressed: () {}),
      ],
    );
  }
}
