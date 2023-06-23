
abstract class TextReplacerState {}

class TextReplacerInitialState extends TextReplacerState {}

class TextReplacerOptionChange extends TextReplacerState {}

class TextReplacerGeneratingText extends TextReplacerState {}

class TextReplacerGeneratedText extends TextReplacerState {}
