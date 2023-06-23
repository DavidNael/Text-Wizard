
abstract class DuplicateRemoverState {}

class DuplicateRemoverInitialState extends DuplicateRemoverState {}

class DuplicateRemoverOptionChange extends DuplicateRemoverState {}

class DuplicateRemoverGeneratingText extends DuplicateRemoverState {}

class DuplicateRemoverGeneratedText extends DuplicateRemoverState {}
