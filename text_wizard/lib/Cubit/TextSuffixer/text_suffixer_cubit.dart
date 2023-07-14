import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextSuffixer/text_suffixer_state.dart';

class TextSuffixerCubit extends Cubit<TextSuffixerState> {
  TextSuffixerCubit() : super(TextSuffixerInitialState());
  static TextSuffixerCubit getCubit(context) => BlocProvider.of(context);
  TextEditingController prefixTextController = TextEditingController();
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();
  Map<String, bool> options = {
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void setOption({String option = "ignoreSpaces"}) {
    options[option] = !options[option]!;
    emit(TextSuffixerOptionChange());
  }

  String textSuffixer() {
    if (prefixTextController.text.isEmpty || inputTextController.text.isEmpty) {
      return inputTextController.text;
    } else {
      TextUtilities textUtilities = TextUtilities();
      return textUtilities.textSuffixer(
        suffix: prefixTextController.text,
        text: inputTextController.text,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
  }
}
