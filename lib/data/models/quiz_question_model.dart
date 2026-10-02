class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correct;
  final String explanation;
  final int xpReward;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correct,
    this.explanation = '',
    this.xpReward = 10,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> data) => QuizQuestion(
        id: data['id'] ?? '',
        question: data['question'] ?? '',
        options: List<String>.from(data['options'] ?? []),
        correct: data['correct'] ?? 0,
        explanation: data['explanation'] ?? '',
        xpReward: data['xpReward'] ?? 10,
      );
}
