import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/features/auth/presentation/pages/login_screen_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");

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
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
          )
        ),
        home: LoginScreenPage(),
      ),
    );
  }
}
