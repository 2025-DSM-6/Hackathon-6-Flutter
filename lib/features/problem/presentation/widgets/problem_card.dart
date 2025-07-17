import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProblemCard extends StatelessWidget {
  final bool showDifficulty;

  const ProblemCard({super.key, this.showDifficulty = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffCCCCCC)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 61.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '공통수학',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1E40AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '난이도 : 상',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '이차함수의 최대값과 최소값 구하기',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff15C65B),
                minimumSize: Size(64.w, 26.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                '문제 풀기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
