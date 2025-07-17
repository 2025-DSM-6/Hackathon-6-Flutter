import 'dart:core';

enum ElectiveSubject {
  server,
  frontend,
  linux,
  ai,
}

class UserModel {
  final int id;
  final String userName;
  final int grade;
  final int classNum;
  final int num;
  final ElectiveSubject electiveSubject;

  UserModel({
    required this.id,
    required this.userName,
    required this.grade,
    required this.classNum,
    required this.num,
    required this.electiveSubject,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    ElectiveSubject subject;
    try {
      subject = ElectiveSubject.values.firstWhere(
            (e) => e.toString().split('.').last == json['elective_subject'],
      );
    } catch (_) {
      subject = ElectiveSubject.server; // 기본값
    }

    return UserModel(
      id: (json['id'])?.toInt() ?? 0,
      userName: json['user_name'] as String? ?? '',
      grade: (json['grade'])?.toInt() ?? 1,
      classNum: (json['class_num'])?.toInt() ?? 1,
      num: (json['num'])?.toInt() ?? 1,
      electiveSubject: subject,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'grade': grade,
      'class_num': classNum,
      'num': num,
      'elective_subject': electiveSubject.toString().split('.').last,
    };
  }
}
