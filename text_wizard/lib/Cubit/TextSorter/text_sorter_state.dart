
abstract class TextSorterState {}

class TextSorterInitialState extends TextSorterState {}

class TextSorterOptionChange extends TextSorterState {}

class TextSorterGeneratingText extends TextSorterState {}

class TextSorterGeneratedText extends TextSorterState {}
