abstract class AnagramGeneratorState {}

class AnagramGeneratorInitialState extends AnagramGeneratorState {}

class AnagramGeneratorOptionChange extends AnagramGeneratorState {}

class AnagramGeneratorGeneratingText extends AnagramGeneratorState {}

class AnagramGeneratorGeneratedText extends AnagramGeneratorState {}

class AnagramGeneratorGeneratedNoWords extends AnagramGeneratorState {}

class AnagramGeneratorGeneratedFewWords extends AnagramGeneratorState {}

class AnagramGeneratorGeneratedAllWords extends AnagramGeneratorState {}
