abstract class TextSuffixerState {}

class TextSuffixerInitialState extends TextSuffixerState {}

class TextSuffixerOptionChange extends TextSuffixerState {}

class TextSuffixerGeneratingText extends TextSuffixerState {}

class TextSuffixerGeneratedText extends TextSuffixerState {}
