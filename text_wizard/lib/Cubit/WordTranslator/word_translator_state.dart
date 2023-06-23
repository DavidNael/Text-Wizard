abstract class WordTranslatorState {}

class WordTranslatorInitialState extends WordTranslatorState {}

class WordTranslatorOptionChange extends WordTranslatorState {}

class WordTranslatorTranslatingWords extends WordTranslatorState {}

class WordTranslatorFinishedTranslatingWords extends WordTranslatorState {}

class WordTranslatorTranslatedNoWords extends WordTranslatorState {}

class WordTranslatorError extends WordTranslatorState {}
