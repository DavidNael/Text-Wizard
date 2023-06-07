import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components/custom_classes.dart';

part 'password_generator_state.dart';

class PasswordGeneratorCubit extends Cubit<PasswordGeneratorState> {
  PasswordGeneratorCubit() : super(PasswordGeneratorInitialState());
  static PasswordGeneratorCubit getCubit(context) => BlocProvider.of(context);
  double passwordLengthValue = 8;
  String password = "";
  List<bool> options = [false, false, false];
  void changeOptionType({required int optionNumber}) {
    options[optionNumber] = !options[optionNumber];
    emit(PasswordGeneratorOptionChange());
  }

  void changeSlider({required double newValue}) {
    passwordLengthValue = newValue;
    emit(PasswordGeneratorOptionChange());
  }

  void generatePassword() {
    password = TextUtilities().passwordGenerator(
      passwordLength: passwordLengthValue.toInt(),
      includeNumbers: options[0],
      includeCapitalLetters: options[1],
      includeSymbols: options[2],
    );
    emit(PasswordGeneratorGeneratedPassword());
  }
}
