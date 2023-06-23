import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextReplacer/text_replacer_state.dart';

class TextReplacerCubit extends Cubit<TextReplacerState> {
  TextReplacerCubit() : super(TextReplacerInitialState());
  static TextReplacerCubit getCubit(context) => BlocProvider.of(context);
}
