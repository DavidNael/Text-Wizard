
abstract class CaseConverterState {}

class CaseConverterInitialState extends CaseConverterState {}

class CaseConverterOptionChange extends CaseConverterState {}

class CaseConverterGeneratingText extends CaseConverterState {}

class CaseConverterGeneratedText extends CaseConverterState {}
