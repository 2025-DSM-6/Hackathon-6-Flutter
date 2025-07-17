import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_button.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';
import 'package:hackathon_6_flutter/features/auth/presentation/pages/login_page.dart';

class LoginScreenPage extends StatelessWidget {
  const LoginScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 32.0.h),
        child: CustomButton(
          text: '로그인',
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
          },
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
