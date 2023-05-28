import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/custom_classes.dart';

part 'word_generator_state.dart';

class WordGeneratorCubit extends Cubit<WordGeneratorState> {
  WordGeneratorCubit() : super(WordGeneratorInitialState());
  static WordGeneratorCubit getCubit(context) => BlocProvider.of(context);
  int wordTypeValue = 0;
  double wordCountSlider = 1;
  double wordLengthSlider = 0;
  List<String> words = [];
  List<bool> checkboxOptions = [false, false, false];
  void changeWordType({required int newValue}) {
    wordTypeValue = newValue;
    emit(WordGeneratorOptionChange());
  }

  void changeSlider({required int sliderId, required double newValue}) {
    if (sliderId == 0) {
      wordLengthSlider = newValue;
    } else if (sliderId == 1) {
      wordCountSlider = newValue;
    }
    emit(WordGeneratorOptionChange());
  }

  void generateWords({
    String startWith = "",
    String endsWith = "",
  }) {
    emit(WordGeneratorGeneratingWords());
    words = CustomWordGenerator().wordGenerator(
      startWith: startWith,
      endsWith: endsWith,
      wordCount: wordCountSlider.toInt(),
      wordLength: wordLengthSlider.toInt(),
      wordType: wordTypeValue,
      isSafeSearch: checkboxOptions[0],
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

  void changeCheckBoxType({required int optionNumber}) {
    checkboxOptions[optionNumber] = !checkboxOptions[optionNumber];
    emit(WordGeneratorOptionChange());
  }
}
