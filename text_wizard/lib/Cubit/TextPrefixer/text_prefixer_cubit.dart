import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextPrefixer/text_prefixer_state.dart';

class TextPrefixerCubit extends Cubit<TextPrefixerState> {
  TextPrefixerCubit() : super(TextPrefixerInitialState());
  static TextPrefixerCubit getCubit(context) => BlocProvider.of(context);
  TextEditingController prefixTextController = TextEditingController();
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();
  Map<String, bool> options = {
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void setOption({String option = "ignoreSpaces"}) {
    options[option] = !options[option]!;
    emit(TextPrefixerOptionChange());
  }

  String textPrefixer() {
    if (prefixTextController.text.isEmpty || inputTextController.text.isEmpty) {
      return inputTextController.text;
    } else {
      TextUtilities textUtilities = TextUtilities();
      return textUtilities.textPrefixer(
        prefix: prefixTextController.text,
        text: inputTextController.text,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
  }
}
