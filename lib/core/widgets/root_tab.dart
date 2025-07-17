import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';
import 'package:hackathon_6_flutter/features/problem/presentation/pages/shared_problem_page.dart';

import '../../features/home/presentation/pages/main_page.dart';
import '../../features/profile/presentation/view/my_page.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  late TabController controller = TabController(length: 3, vsync: this);

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2.w,
              color: const Color(0xffE1E1E1),
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          // type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(
            color: const Color(0xff717171),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
          selectedLabelStyle: TextStyle(
            color: const Color(0xff15C65B),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: index == 0 ? Image.asset(
                Images.coloredMessageQuestion,
                width: 22.w,
                height: 22.h,
              ) : Image.asset(
                Images.messageQuestion,
                width: 22.w,
                height: 22.h,
              ),
              label: "공유 문제",
            ),
            BottomNavigationBarItem(
              icon: index == 1 ? Image.asset(
                Images.coloredHome,
                width: 25.w,
                height: 25.h,
              ) : Image.asset(
                Images.home,
                width: 25.w,
                height: 25.h,
              ),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: index == 2 ? Image.asset(
                Images.coloredPerson,
                width: 19.w,
                height: 19.h,
              ) : Image.asset(
                Images.person,
                width: 19.w,
                height: 19.h,
              ),
              label: "마이페이지",
            ),
          ],
        ),
      ),
      child: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SharedProblemPage(),
          MainPage(),
          const MyPage(),
        ],
      ),
    );
  }
}
