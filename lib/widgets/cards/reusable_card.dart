import 'package:flutter/material.dart';
import '../../core/responsive_extensions.dart';
import '../../design_system/radius.dart';
import '../../design_system/shadows.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? background;

  const ReusableCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.trailing,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? Theme.of(context).cardColor,
      elevation: 0,
      borderRadius: BorderRadius.circular(RadiusToken.medium),
      child: InkWell(
        borderRadius: BorderRadius.circular(RadiusToken.medium),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              if (icon != null)
                Icon(icon, size: 22.sp).paddingSymmetric(horizontal: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
