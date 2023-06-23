import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/WordWrapper/word_wrapper_state.dart';

class WordWrapperCubit extends Cubit<WordWrapperState> {
  WordWrapperCubit() : super(WordWrapperInitialState());
  static WordWrapperCubit getCubit(context) => BlocProvider.of(context);
}
