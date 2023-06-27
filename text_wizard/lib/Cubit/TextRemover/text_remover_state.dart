
abstract class TextRemoverState {}

class TextRemoverInitialState extends TextRemoverState {}

class TextRemoverOptionChange extends TextRemoverState {}

class TextRemoverGeneratingText extends TextRemoverState {}

class TextRemoverGeneratedText extends TextRemoverState {}
