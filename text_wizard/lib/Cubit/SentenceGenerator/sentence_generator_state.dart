part of 'sentence_generator_cubit.dart';

abstract class SentenceGeneratorState {}

class SentenceGeneratorInitialState extends SentenceGeneratorState {}

class SentenceGeneratorOptionChange extends SentenceGeneratorState {}

class SentenceGeneratorGeneratingWords extends SentenceGeneratorState {}

class SentenceGeneratorGeneratedWords extends SentenceGeneratorState {}
