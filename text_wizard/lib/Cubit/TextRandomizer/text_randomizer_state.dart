
abstract class TextRandomizerState {}

class TextRandomizerInitialState extends TextRandomizerState {}

class TextRandomizerOptionChange extends TextRandomizerState {}

class TextRandomizerGeneratingText extends TextRandomizerState {}

class TextRandomizerGeneratedText extends TextRandomizerState {}
