import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_generator_state.dart';

class WordGeneratorCubit extends Cubit<WordGeneratorState> {
  WordGeneratorCubit() : super(WordGeneratorInitialState());
  static WordGeneratorCubit getCubit(context) => BlocProvider.of(context);
  int wordTypeValue = 0;
  void changeWordType({required int newValue}) {
    wordTypeValue = newValue;
    emit(WordGeneratorOptionChange());
  }
}
