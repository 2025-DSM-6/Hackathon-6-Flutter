import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xffE4E4E4),
              width: 1.h,
            ),
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.0.w, vertical: 13.h),
          child: AppBar(
            leading: Image.asset(
              Images.logo,
              width: 21.7.w,
              height: 29.55.h,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(58.h);
}