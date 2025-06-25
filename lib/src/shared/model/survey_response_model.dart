class SurveyResponse {
  final int questionId;
  final int rating;
  final String comment;

  SurveyResponse({
    required this.questionId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "rating": rating,
    "comment": comment,
  };
}
