import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_button.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';
import 'package:hackathon_6_flutter/features/home/data/model/subject_response.dart';
import 'package:hackathon_6_flutter/features/home/data/repository/subject_repository.dart';
import 'package:hackathon_6_flutter/features/problem/presentation/pages/solve_problem_page.dart';

import '../../../../core/images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SubjectRepository _repository = SubjectRepository();
  late final Future<SubjectResponse> _subjectFuture;

  SubjectBody? selectedSubject;

  @override
  void initState() {
    super.initState();
    _subjectFuture = _repository.fetchSubject();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 38.0.w, right: 38.0.w, bottom: 24.0.h),
        child: CustomButton(
          text: '문제풀이 시작하기',
          backgroundColor: const Color(0xff15C65B),
          onPressed: selectedSubject != null
              ? () {
                  final scope = selectedSubject!.range
                      .map((r) => '${r.examName}: ${r.examContent}')
                      .join('\n');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SolveProblemPage(
                        subject: selectedSubject!.subjectName,
                        scope: scope,
                      ),
                    ),
                  );
                }
              : null,
        ),
      ),
      child: FutureBuilder<SubjectResponse>(
        future: _subjectFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('오류가 발생했습니다'),
                  const SizedBox(height: 8),
                  Text('${snapshot.error}', style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('학습할 과목이 없어요'));
          }

          final subjects = snapshot.data!.data;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 95.h),
                Text(
                  '학습할 과목을 선택하세요',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    final isSelected =
                        selectedSubject?.subjectId == subject.subjectId;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSubject = subject;
                        });
                      },
                      child: SubjectCard(
                        icon: subjectIconMapper(subject.subjectName),
                        title: subject.subjectName,
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }

  String subjectIconMapper(String subject) {
    switch (subject) {
      case "공통국어":
        return Images.korea;
      case "공통수학":
        return Images.math;
      case "통합과학":
        return Images.science;
      case "영어":
        return Images.english;
      case "영어1":
        return Images.english;
      case "통합사회":
        return Images.society;
      case "프로그래밍":
        return Images.web;
      case "컴퓨터 구조":
        return Images.cs;
      case "운영체제":
        return Images.os;
      case "데이터베이스 프로그래밍":
        return Images.db;
      case "웹 프로그래밍":
        return Images.web;
      case "문학":
        return Images.book;
      case "인공지능 활용":
        return Images.ai;
      case "한국사":
        return Images.history;
      case "포론트엔드 프로그래밍":
        return Images.fe;
      case "서버 프로그래밍":
        return Images.server;
      case "확률과 통계":
        return Images.insight;
      default:
        return Images.questionMarker;
    }
  }
}

class SubjectCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;

  const SubjectCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget;
    if (icon.endsWith('.svg')) {
      imageWidget = SvgPicture.asset(
        icon,
        width: 36,
        height: 36,
        colorFilter: const ColorFilter.mode(
          Color(0xff15C65B),
          BlendMode.srcIn,
        ),
      );
    } else {
      imageWidget = Image.asset(
        icon,
        width: 36,
        height: 36,
        color: const Color(0xff15C65B),
      );
    }

    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: isSelected ? 2.w : 1.w,
          color: isSelected ? const Color(0xff15C65B) : const Color(0xffE5E7EB),
        ),
        color: isSelected ? const Color(0xffECFDF5) : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageWidget,
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: isSelected ? const Color(0xff15C65B) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}