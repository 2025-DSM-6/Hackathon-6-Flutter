class QuizModel {
  final int questionId;
  final String question;
  final List<String> options;
  final String hint;
  final String answer;
  final String difficulty;
  final int score;

  QuizModel({
    required this.questionId,
    required this.question,
    required this.options,
    required this.hint,
    required this.answer,
    required this.difficulty,
    required this.score,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questionId: (json['question_id'] as num?)?.toInt() ?? 0,
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      hint: json['hint'] ?? '',
      answer: json['answer'] ?? '',
      difficulty: json['difficulty'] ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
    );
  }
}