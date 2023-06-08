import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components/custom_classes.dart';
import 'name_generator_state.dart';

class NameGeneratorCubit extends Cubit<NameGeneratorState> {
  NameGeneratorCubit() : super(NameGeneratorInitialState());
  static NameGeneratorCubit getCubit(context) => BlocProvider.of(context);
  double nameCountSlider = 1;
  double nameLengthSlider = 0;
  List<String> names = [];
  List<bool> checkboxOptions = [false, false, false];

  void changeSlider({required int sliderId, required double newValue}) {
    if (sliderId == 0) {
      nameLengthSlider = newValue;
    } else if (sliderId == 1) {
      nameCountSlider = newValue;
    }
    emit(NameGeneratorOptionChange());
  }

  void generateWords({
    String startWith = "",
    String endsWith = "",
  }) {
    emit(NameGeneratorGeneratingWords());
    names = TextUtilities().nameGenerator(
      startWith: startWith,
      endsWith: endsWith,
      nameCount: nameCountSlider.toInt(),
      nameLength: nameLengthSlider.toInt(),
    );
    emit(NameGeneratorFinishedGeneratingWords());
    if (names.isEmpty) {
      emit(NameGeneratorGeneratedNoWords());
      return;
    }
    if (nameCountSlider > names.length) {
      emit(NameGeneratorGeneratedFewWords());
      return;
    }
    emit(NameGeneratorGeneratedAllWords());
  }

  void changeCheckBoxType({required int optionNumber}) {
    checkboxOptions[optionNumber] = !checkboxOptions[optionNumber];
    emit(NameGeneratorOptionChange());
  }
}
