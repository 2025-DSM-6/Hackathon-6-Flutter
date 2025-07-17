class ExamRange {
  final String examName;
  final String examContent;

  ExamRange({
    required this.examName,
    required this.examContent,
  });
  
  factory ExamRange.fromJson(Map<String, dynamic> json) {
    return ExamRange(
      examName: json['exam_name'] ?? '',
      examContent: json['exam_content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_name': examName,
      'exam_content': examContent,
    };
  }
}

class SubjectBody {
  final int subjectId;
  final String subjectName;
  final String memo;
  final List<ExamRange> range;

  SubjectBody({
    required this.subjectId,
    required this.subjectName,
    required this.memo,
    required this.range,
  });

  factory SubjectBody.fromJson(Map<String, dynamic> json) {
    return SubjectBody(
      subjectId: json['subject_id'] as int? ?? 0,
      subjectName: json['subject_name'] ?? '',
      memo: json['memo'] ?? '',
      range: (json['range'] as List<dynamic>?)
          ?.map((e) => ExamRange.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'memo': memo,
      'range': range.map((e) => e.toJson()).toList(),
    };
  }
}

class SubjectResponse {
  final String status;
  final String message;
  final List<SubjectBody> data;

  SubjectResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SubjectBody.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
