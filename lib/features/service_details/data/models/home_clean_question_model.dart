/// A question shown on the Requirements step.
/// Each question has a label and a list of selectable [options].
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
  /// Row of pill buttons — one selected at a time.
  pill,

  /// Single numeric value incremented / decremented with +/- buttons.
  stepper,
}

