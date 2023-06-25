import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/CaseConverter/case_converter_state.dart';

import '../../Components/ui_widgets.dart';

class CaseConverterCubit extends Cubit<CaseConverterState> {
  CaseConverterCubit() : super(CaseConverterInitialState());
  static CaseConverterCubit getCubit(context) => BlocProvider.of(context);
  int inputCase = 0;
  int outputCase = 1;
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
      value: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(
          text: "lowercase",
        ),
      ),
    ),
    DropdownMenuItem(
      value: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Uppercase"),
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Title Case"),
      ),
    ),
    DropdownMenuItem(
      value: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Sentence case"),
      ),
    ),
    DropdownMenuItem(
      value: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Alternating Case"),
      ),
    ),
    DropdownMenuItem(
      value: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Random Case"),
      ),
    ),
    DropdownMenuItem(
      value: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Camel Case"),
      ),
    ),
    DropdownMenuItem(
      value: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Snake Case"),
      ),
    ),
    DropdownMenuItem(
      value: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Kebab Case"),
      ),
    ),
    DropdownMenuItem(
      value: 9,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: customText(text: "Pascal Case"),
      ),
    ),
  ];
  TextUtilities textUtilities = TextUtilities();
  void updateCase({int? newInputCase, int? newOutputCase}) {
    if (newInputCase != null) {
      inputCase = newInputCase;
    }
    if (newOutputCase != null) {
      outputCase = newOutputCase;
    }
    emit(CaseConverterOptionChange());
  }

  String convertCase({String text = ""}) {
    emit(CaseConverterGeneratingText());
    final newText = textUtilities.caseConverter(
      text: text,
      inputCaseType: inputCase,
      outputCaseType: outputCase,
    );
    emit(CaseConverterGeneratedText());
    return newText;
  }
}
