import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/AnagramGenerator/anagram_generator_state.dart';

class AnagramGeneratorCubit extends Cubit<AnagramGeneratorState> {
  AnagramGeneratorCubit() : super(AnagramGeneratorInitialState());
  static AnagramGeneratorCubit getCubit(context) => BlocProvider.of(context);
  List<String> anagrams = [];
}
