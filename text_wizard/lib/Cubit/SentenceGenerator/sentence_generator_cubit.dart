import 'package:flutter_bloc/flutter_bloc.dart';

part 'sentence_generator_state.dart';

class SentenceGeneratorCubit extends Cubit<SentenceGeneratorState> {
  SentenceGeneratorCubit() : super(SentenceGeneratorInitialState());
  static SentenceGeneratorCubit getCubit(context) => BlocProvider.of(context);
  int wordTypeValue = 0;
  double sliderValue = 1;
  void changeWordType({required int newValue}) {
    wordTypeValue = newValue;
    emit(SentenceGeneratorOptionChange());
  }

  void changeSlider({required double newValue}) {
    sliderValue = newValue;
    emit(SentenceGeneratorOptionChange());
  }
}
