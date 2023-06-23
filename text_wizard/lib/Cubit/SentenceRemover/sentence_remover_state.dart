
abstract class SentenceRemoverState {}

class SentenceRemoverInitialState extends SentenceRemoverState {}

class SentenceRemoverOptionChange extends SentenceRemoverState {}

class SentenceRemoverGeneratingText extends SentenceRemoverState {}

class SentenceRemoverGeneratedText extends SentenceRemoverState {}
