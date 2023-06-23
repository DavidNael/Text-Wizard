
abstract class TextPrefixerState {}

class TextPrefixerInitialState extends TextPrefixerState {}

class TextPrefixerOptionChange extends TextPrefixerState {}

class TextPrefixerGeneratingText extends TextPrefixerState {}

class TextPrefixerGeneratedText extends TextPrefixerState {}
