import 'dart:core';

class RankingResponse {
  final List<UserRank> top10;
  final UserRank? myRank;

  RankingResponse({
    required this.top10,
    this.myRank,
  });

  factory RankingResponse.fromJson(Map<String, dynamic> json) {
    return RankingResponse(
      top10: (json['top_10'] as List)
          .map((e) => UserRank.fromJson(e))
          .toList(),
      myRank: json['my_rank'] != null
          ? UserRank.fromJson(json['my_rank'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'top_10': top10.map((e) => e.toJson()).toList(),
      'my_rank': myRank?.toJson(),
    };
  }
}

class UserRank {
  final int userId;
  final String? username;
  final double score;
  final int? grade;
  final int? classNum;
  final int? num;

  UserRank({
    required this.userId,
    required this.username,
    required this.score,
    this.grade,
    this.classNum,
    this.num,
  });

  factory UserRank.fromJson(Map<String, dynamic> json) {
    return UserRank(
      userId: json['user_id'] as int,
      username: json['username'],
      score: (json['score']).toDouble(),
      grade: json['grade'],
      classNum: json['class_num'],
      num: json['num'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'score': score,
      'grade': grade,
      'class_num': classNum,
      'num': num,
    };
  }
}