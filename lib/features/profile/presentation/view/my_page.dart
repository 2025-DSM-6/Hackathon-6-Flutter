import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';
import 'package:hackathon_6_flutter/features/auth/presentation/pages/login_screen_page.dart';
import 'package:hackathon_6_flutter/features/auth/service/auth_service.dart';
import 'package:hackathon_6_flutter/features/profile/data/repositories/user_repository.dart';

import '../../data/models/user_model.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<String> _dropdownItems = [
    '서버 프로그래밍',
    '프론트앤드\n프로그래밍',
    '리눅스 프로그래밍',
    '인공지능 활용',
  ];

  final rankings = [
    {'rank': 1, 'name': '2206 민수아', 'score': 100},
    {'rank': 2, 'name': '2206 민수아', 'score': 100},
    {'rank': 3, 'name': '2206 민수아', 'score': 100},
    {'rank': 4, 'name': '2206 민수아', 'score': 100},
    {'rank': 5, 'name': '2206 민수아', 'score': 100},
    {'rank': 18, 'name': '2206 민수아', 'score': 100, 'myranking': true},
  ];

  String? _selectedItem;

  final UserRepository repository = UserRepository();
  late final Future<UserModel> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = repository.fetchUser();
  }

  String getDepartment(int grade, int classNum) {
    if (grade == 1) return '공통과정';

    switch (classNum) {
      case 1:
        return '소프트웨어 개발과';
      case 2:
        return '소프트웨어 개발과';
      case 3:
        return '임베디드 SW 개발과';
      case 4:
        return '인공지능 SW 개발과';
      default:
        return '기타';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: FutureBuilder<UserModel>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text('유저 정보를 불러오는데 실패했습니다'),
                  SizedBox(height: 8),
                  Text('${snapshot.error}', style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('유저 정보가 없습니다.'),
            );
          }

          final user = snapshot.data!;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.0.w),
            child: Column(
              children: [
                SizedBox(height: 56.h),
                Row(
                  children: [
                    Image.asset(
                      Images.profile,
                      width: 62.w,
                      height: 62.h,
                    ),
                    SizedBox(width: 24.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.grade}${user.classNum}${user.num.toString().padLeft(2, '0')} ${user.userName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          getDepartment(user.grade, user.classNum),
                          style: TextStyle(
                            color: const Color(0xff5A5A5A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreenPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 64.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              color: const Color(0xffB9B9B9), width: 1.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.logout,
                              width: 12.w,
                              height: 12.h,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '로그아웃',
                              style: TextStyle(
                                color: const Color(0xff5E5E5E),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27.h),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '나의 점수는?',
                          style: TextStyle(
                            color: const Color(0xff065425),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 140.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xffF3F3F3),
                              width: 2.w,
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '10',
                                  style: TextStyle(
                                    color: const Color(0xff5F5F5F),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  '점',
                                  style: TextStyle(
                                    color: const Color(0xff5F5F5F),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 36.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '선택 과목',
                          style: TextStyle(
                            color: const Color(0xff065425),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        DropdownButton2<String>(
                          isExpanded: true,
                          value: _selectedItem,
                          underline: const SizedBox.shrink(),
                          buttonStyleData: ButtonStyleData(
                            height: 50.h,
                            width: 140.w,
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                  color: const Color(0xffF3F3F3), width: 2.w),
                              color: Colors.white,
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.w),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Image.asset(
                              Images.upArrow,
                              width: 12.w,
                              height: 12.h,
                            ),
                            iconEnabledColor: Colors.black,
                          ),
                          items: _dropdownItems.map(
                            (String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: const Color(0xff4E4E4E),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 27.h),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Images.trophyIcon,
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '우리학교 전체 랭킹',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Container(
                      width: 310.w,
                      height: 419.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 22.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffE8E8E8), width: 2.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ListView.separated(
                        itemCount: rankings.length,
                        itemBuilder: (context, index) {
                          final item = rankings[index];
                          return RankingTile(
                            rank: item['rank'] as int,
                            name: item['name'] as String,
                            score: item['score'] as int,
                            highlight: item['myranking'] == true,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15.h);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RankingTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final bool highlight;

  const RankingTile({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    this.highlight = false,
  });

  Widget _buildRankIcon() {
    switch (rank) {
      case 1:
        return Image.asset(
          Images.goldMedal,
          width: 25.w,
          height: 25.h,
        );
      case 2:
        return Image.asset(
          Images.silverMedal,
          width: 25.w,
          height: 25.h,
        );
      case 3:
        return Image.asset(
          Images.bronzeMedal,
          width: 25.w,
          height: 25.h,
        );
      default:
        return CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white,
          child: Text(
            '$rank',
            style: TextStyle(
              color: const Color(0xff535353),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _buildRankIcon(),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff5A5A5A),
              ),
            ),
          ),
          Text(
            '$score 점',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
