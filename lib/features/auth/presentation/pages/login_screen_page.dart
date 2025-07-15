import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_button.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';

class LoginScreenPage extends StatelessWidget {
  const LoginScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 60.0.h),
        child: CustomButton(
          text: '로그인',
          onPressed: () {},
          backgroundColor: const Color(0xff15C65B),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 78.w,
              height: 106.21.h,
            ),
          ],
        ),
      ),
    );
  }
}
