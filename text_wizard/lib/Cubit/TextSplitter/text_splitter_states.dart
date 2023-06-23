
abstract class TextSplitterState {}

class TextSplitterInitialState extends TextSplitterState {}

class TextSplitterOptionChange extends TextSplitterState {}

class TextSplitterGeneratingText extends TextSplitterState {}

class TextSplitterGeneratedText extends TextSplitterState {}
