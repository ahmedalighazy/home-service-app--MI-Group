class HomeCleanQuestion {
  final String label;
  final List<String> options;
  final QuestionType type;
  int selectedOptionIndex;

  HomeCleanQuestion({
    required this.label,
    required this.options,
    this.type = QuestionType.pill,
    this.selectedOptionIndex = 0,
  });
}

enum QuestionType {

  pill,

  stepper,
}
