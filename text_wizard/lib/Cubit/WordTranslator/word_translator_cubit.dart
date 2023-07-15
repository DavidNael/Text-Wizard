import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/WordTranslator/word_translator_state.dart';

import '../../Components/custom_classes.dart';
import '../../Constants/language_code.dart';

class WordTranslatorCubit extends Cubit<WordTranslatorState> {
  WordTranslatorCubit() : super(WordTranslatorInitialState());
  static WordTranslatorCubit getCubit(context) => BlocProvider.of(context);
  String inputLanguage = 'Auto Detect';
  String outputLanguage = 'English';
  String inputText = "";
  void changeLanguage({required bool isInput, required String newValue}) {
    if (isInput) {
      inputLanguage = newValue;
    } else {
      outputLanguage = newValue;
    }

    emit(WordTranslatorOptionChange());
  }

  void changeInputText({required String newValue}) {
    inputText = newValue;
    emit(WordTranslatorOptionChange());
  }

  void swapLanguages() {
    final temp = inputLanguage;
    inputLanguage = outputLanguage;
    outputLanguage = temp;
    emit(WordTranslatorOptionChange());
  }

  Future<String> translateText() async {
    emit(WordTranslatorTranslatingWords());
    final translation = TextUtilities.translateText(
      text: "$inputText ",
      inputLanguage: inputLanguage == "Auto Detect"
          ? 'auto'
          : languageCodeMap[inputLanguage]!,
      outputLanguage: languageCodeMap[outputLanguage]!,
    );
    return translation;
  }
}
