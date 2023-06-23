
abstract class UnicodeConverterState {}

class UnicodeConverterInitialState extends UnicodeConverterState {}

class UnicodeConverterOptionChange extends UnicodeConverterState {}

class UnicodeConverterGeneratingText extends UnicodeConverterState {}

class UnicodeConverterGeneratedText extends UnicodeConverterState {}
