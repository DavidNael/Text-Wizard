
abstract class NameGeneratorState {}

class NameGeneratorInitialState extends NameGeneratorState {}

class NameGeneratorOptionChange extends NameGeneratorState {}

class NameGeneratorGeneratingWords extends NameGeneratorState {}

class NameGeneratorFinishedGeneratingWords extends NameGeneratorState {}

class NameGeneratorGeneratedNoWords extends NameGeneratorState {}

class NameGeneratorGeneratedFewWords extends NameGeneratorState {}

class NameGeneratorGeneratedAllWords extends NameGeneratorState {}
