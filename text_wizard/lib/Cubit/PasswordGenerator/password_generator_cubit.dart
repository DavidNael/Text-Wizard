import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_generator_state.dart';

class PasswordGeneratorCubit extends Cubit<PasswordGeneratorState> {
  PasswordGeneratorCubit() : super(PasswordGeneratorInitialState());
  static PasswordGeneratorCubit getCubit(context) => BlocProvider.of(context);
  double sliderValue = 1;
  List<bool> options = [false, false, false];
  void changeOptionType({required int optionNumber}) {
    options[optionNumber] = !options[optionNumber];
    emit(PasswordGeneratorOptionChange());
  }

  void changeSlider({required double newValue}) {
    sliderValue = newValue;
    emit(PasswordGeneratorOptionChange());
  }
}
