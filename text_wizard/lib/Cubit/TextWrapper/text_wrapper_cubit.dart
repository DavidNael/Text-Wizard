import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextWrapper/text_wrapper_state.dart';

import '../../Components/custom_classes.dart';

class TextWrapperCubit extends Cubit<TextWrapperState> {
  TextWrapperCubit() : super(TextWrapperInitialState());
  static TextWrapperCubit getCubit(context) => BlocProvider.of(context);
  TextEditingController prefixTextController = TextEditingController();
  TextEditingController suffixTextController = TextEditingController();
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();
  Map<String, bool> options = {
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void setOption({String option = "ignoreSpaces"}) {
    options[option] = !options[option]!;
    emit(TextWrapperOptionChange());
  }

  String textWrapper() {
    if (prefixTextController.text.isEmpty || inputTextController.text.isEmpty) {
      return inputTextController.text;
    } else {
      return TextUtilities.textWrapper(
        prefix: prefixTextController.text,
        suffix: suffixTextController.text,
        text: inputTextController.text,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
  }
}
