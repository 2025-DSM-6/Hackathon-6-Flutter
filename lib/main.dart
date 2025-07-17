import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/features/auth/presentation/pages/login_screen_page.dart';
import 'package:hackathon_6_flutter/init/dio_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  dioInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
          ),
        ),
        home: const LoginScreenPage(),
      ),
    );
  }
}
