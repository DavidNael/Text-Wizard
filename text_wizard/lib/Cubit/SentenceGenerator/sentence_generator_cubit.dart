import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';

part 'sentence_generator_state.dart';

class SentenceGeneratorCubit extends Cubit<SentenceGeneratorState> {
  SentenceGeneratorCubit() : super(SentenceGeneratorInitialState());
  static SentenceGeneratorCubit getCubit(context) => BlocProvider.of(context);
  int wordTypeValue = 0;
  double sentenceWordsSliderValue = 1;
  double sentenceLinesSliderValue = 5;
  List<bool> checkboxOptions = [false, false, false];
  String sentence = "";
  void changeWordType({required int newValue}) {
    wordTypeValue = newValue;
    emit(SentenceGeneratorOptionChange());
  }

  void changeSlider({required int sliderId, required double newValue}) {
    if (sliderId == 0) {
      sentenceWordsSliderValue = newValue;
    } else if (sliderId == 1) {
      sentenceLinesSliderValue = newValue;
    }
    emit(SentenceGeneratorOptionChange());
  }

  void changeCheckBoxValue({required int checkboxNumber}) {
    checkboxOptions[checkboxNumber] = !checkboxOptions[checkboxNumber];
    emit(SentenceGeneratorOptionChange());
  }

  void generateSentence({
    int wordType = 0,
    int sentenceLength = 1,
    int sentenceLines = 5,
  }) {
    emit(SentenceGeneratorGeneratingSentence());
    sentence = TextUtilities().sentenceGenerator(
      wordType: wordType,
      sentenceLength: sentenceLength,
      sentenceLines: sentenceLines,
      isSafeSearch: checkboxOptions[0],
      shouldAddCommas: checkboxOptions[1],
    );
    emit(SentenceGeneratorFinishedGeneratingSentence());
  }
}
