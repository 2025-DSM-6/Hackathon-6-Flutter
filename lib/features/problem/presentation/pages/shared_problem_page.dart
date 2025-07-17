import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackathon_6_flutter/core/widgets/custom_scaffold.dart';

import '../widgets/problem_card.dart';

class SharedProblemPage extends StatelessWidget {
  const SharedProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Center(
            child: Text(
              '공유 문제',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: 158.w,
              height: 44.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: '국어',
                  items: ['국어', '수학', '영어'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (_) {},
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProblemCard(showDifficulty: index == 0);
              },
              separatorBuilder: (context, index){
                return SizedBox(height: 24.h);
              },
            ),
          ),
        ],
      ),
    );
  }


}
