part of 'word_generator_cubit.dart';

abstract class WordGeneratorState {}

class WordGeneratorInitialState extends WordGeneratorState {}

class WordGeneratorOptionChange extends WordGeneratorState {}

class WordGeneratorGeneratingWords extends WordGeneratorState {}
class WordGeneratorFinishedGeneratingWords extends WordGeneratorState {}

class WordGeneratorGeneratedNoWords extends WordGeneratorState {}
class WordGeneratorGeneratedFewWords extends WordGeneratorState {}
class WordGeneratorGeneratedAllWords extends WordGeneratorState {}
