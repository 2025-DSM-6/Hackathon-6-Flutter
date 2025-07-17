import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';
import 'package:hackathon_6_flutter/core/widgets/root_tab.dart';
import 'package:hackathon_6_flutter/features/auth/service/auth_service.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController idController;
  late TextEditingController passwordController;
  final AuthService _authService = AuthService();

  bool isPasswordVisible = false;

  Future<void> _handleLogin() async {
    if (idController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력해주세요')),
      );
      return;
    }

    try {
      final success = await _authService.login(
        idController.text.trim(),
        passwordController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인 성공')),
        );
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const RootTab()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인 실패')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 32.0.h),
        child: CustomButton(
          text: '시작하기',
          onPressed: () {
            _handleLogin();
          },
          backgroundColor: const Color(0xff15C65B),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 107.h),
            Text(
              '대모험에\n오신 것을 환영합니다!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '스퀘어 계정으로 로그인해주세요!',
              style: TextStyle(
                color: const Color(0xffB6B6B6),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40.h),
            CustomTextField(
              hintText: 'DSM 아이디를 입력해주세요.',
              controller: idController,
            ),
            SizedBox(height: 50.h),
            CustomTextField(
              hintText: 'DSM 비밀번호를 입력해주세요.',
              controller: passwordController,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
