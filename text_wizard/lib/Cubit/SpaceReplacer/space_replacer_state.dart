
abstract class SpaceReplacerState {}

class SpaceReplacerInitialState extends SpaceReplacerState {}

class SpaceReplacerOptionChange extends SpaceReplacerState {}

class SpaceReplacerGeneratingText extends SpaceReplacerState {}

class SpaceReplacerGeneratedText extends SpaceReplacerState {}
