import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/images.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';

import '../../data/model/quiz_model.dart';
import '../../data/repository/quiz_repository.dart';

class SolveProblemPage extends StatefulWidget {
  final String subject;
  final String scope;

  const SolveProblemPage({
    super.key,
    required this.subject,
    required this.scope,
  });

  @override
  State<SolveProblemPage> createState() => _SolveProblemPageState();
}

class _SolveProblemPageState extends State<SolveProblemPage> {
  final QuizRepository repository = QuizRepository();
  late final Future<QuizModel> _quizFuture;

  int? selectedOption;
  bool _showHint = false;
  bool _usedHint = false;

  @override
  void initState() {
    super.initState();
    _quizFuture = repository.fetchQuiz(widget.subject, widget.scope);
  }

  Widget buildOption(int index, String text) {
    final bool isSelected = selectedOption == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected
                  ? const Color(0xff15C65B)
                  : const Color(0xffEBEBEB),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xff005421),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 13.w),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: const Color(0xff3E3E3E),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: FutureBuilder<QuizModel>(
        future: _quizFuture,
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
                  const Text('문제를 불러오는데 실패했습니다'),
                  const SizedBox(height: 8),
                  Text('${snapshot.error}',
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('문제를 불러오지 못했습니다.'),
            );
          }

          final quiz = snapshot.data!;

          return Center(
            child: Container(
              width: 310.w,
              height: 580.h,
              padding: EdgeInsets.symmetric(
                horizontal: 21.w,
                vertical: 33.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE5E7EB)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Images.questionMarker,
                          width: 30.w,
                          height: 30.h,
                        ),
                        SizedBox(width: 9.w),
                        Expanded(
                          child: Text(
                            quiz.question,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Image.asset(
                          Images.trophyIcon,
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 4.w),
                        Row(
                          children: [
                            Text(
                              '난이도 : ${quiz.difficulty}',
                              style: TextStyle(
                                color: const Color(0xff5E5E5E),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    if (_showHint)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          '힌트: ${quiz.hint}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    SizedBox(height: 61.h),
                    ...List.generate(
                      quiz.options.length,
                      (index) => buildOption(index, quiz.options[index]),
                    ),
                    SizedBox(height: 32.h),
                    ElevatedButton.icon(
                      onPressed: selectedOption == null
                          ? null
                          : () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            Images.profile, // assets/images/check.png 사용
                                            width: 80.w, // 적절한 크기 조절
                                            height: 80.h, // 적절한 크기 조절
                                          ),
                                          SizedBox(height: 16.h), // 이미지와 텍스트 사이 간격
                                          Text(
                                            '맞았어요!',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff15C65B), // 초록색
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // 다이얼로그 닫기
                                          },
                                          child: const Text('확인'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                            },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      label: Text(
                        '정답 제출',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff15C65B),
                        minimumSize: Size(270.w, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showHint = true;
                          _usedHint = true;
                        });
                      },
                      icon:
                          const Icon(Icons.lightbulb, color: Color(0xff15C65B)),
                      label: const Text(
                        '힌트 보기',
                        style: TextStyle(color: Color(0xff15C65B)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: const Color(0xff15C65B), width: 1.w),
                        minimumSize: Size(270.w, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          await repository.shareProblem(
                            questionId: quiz.questionId,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('문제가 공유되었습니다.')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('공유 실패: $e')),
                          );
                        }
                      },
                      icon: const Icon(Icons.send, color: Color(0xff15C65B)),
                      label: const Text(
                        '문제 공유하기',
                        style: TextStyle(color: Color(0xff15C65B)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: const Color(0xff15C65B), width: 1.w),
                        minimumSize: Size(270.w, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '나가기',
                            style: TextStyle(
                                color: const Color(0xff636363),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Image.asset(
                            Images.logout,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
