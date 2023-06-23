
abstract class TextFormatterState {}

class TextFormatterInitialState extends TextFormatterState {}

class TextFormatterOptionChange extends TextFormatterState {}

class TextFormatterGeneratingText extends TextFormatterState {}

class TextFormatterGeneratedText extends TextFormatterState {}
