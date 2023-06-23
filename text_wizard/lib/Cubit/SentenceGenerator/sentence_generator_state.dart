
abstract class SentenceGeneratorState {}

class SentenceGeneratorInitialState extends SentenceGeneratorState {}

class SentenceGeneratorOptionChange extends SentenceGeneratorState {}

class SentenceGeneratorGeneratingSentence extends SentenceGeneratorState {}

class SentenceGeneratorFinishedGeneratingSentence extends SentenceGeneratorState {}

class SentenceGeneratorGeneratedWords extends SentenceGeneratorState {}
