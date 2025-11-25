import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/responsive_extensions.dart';
import '../../design_system/radius.dart';

class AdaptiveListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AdaptiveListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS =
        Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.macOS;

    if (isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              if (leading != null) Icon(leading, size: 22.sp),
              SizedBox(width: 10.w),
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
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                      ),
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else
                Icon(Icons.chevron_right, size: 22.sp),
            ],
          ),
        ),
      );
    }

    return ListTile(
      leading: leading != null ? Icon(leading, size: 22.sp) : null,
      title: Text(title, style: TextStyle(fontSize: 15.sp)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: TextStyle(fontSize: 13.sp))
          : null,
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusToken.medium),
      ),
    );
  }
}
