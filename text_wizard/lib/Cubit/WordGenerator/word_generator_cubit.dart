import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/functions.dart';

part 'word_generator_state.dart';

class WordGeneratorCubit extends Cubit<WordGeneratorState> {
  WordGeneratorCubit() : super(WordGeneratorInitialState());
  static WordGeneratorCubit getCubit(context) => BlocProvider.of(context);
  int wordTypeValue = 0;
  double wordCountSlider = 1;
  double wordLengthSlider = 0;
  List<String> words = [];
  void changeWordType({required int newValue}) {
    wordTypeValue = newValue;
    emit(WordGeneratorOptionChange());
  }

  void changeSlider({required int sliderCount, required double newValue}) {
    if (sliderCount == 0) {
      wordLengthSlider = newValue;
    } else if (sliderCount == 1) {
      wordCountSlider = newValue;
    }
    emit(WordGeneratorOptionChange());
  }

  void generateWords({
    String startWith = "",
    String endsWith = "",
  }) {
    emit(WordGeneratorGeneratingWords());
    words = wordGenerator(
      startWith: startWith,
      endsWith: endsWith,
      wordCount: wordCountSlider.toInt(),
      wordLength: wordLengthSlider.toInt(),
      wordType: wordTypeValue,
    );
    emit(WordGeneratorFinishedGeneratingWords());
    if (words.isEmpty) {
      emit(WordGeneratorGeneratedNoWords());
      return;
    }
    if (wordCountSlider > words.length) {
      emit(WordGeneratorGeneratedFewWords());
      return;
    }
    emit(WordGeneratorGeneratedAllWords());
  }
}
