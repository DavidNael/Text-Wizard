import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextRandomizer/text_randomizer_state.dart';

class TextRandomizerCubit extends Cubit<TextRandomizerState> {
  TextRandomizerCubit() : super(TextRandomizerInitialState());
  static TextRandomizerCubit getCubit(context) => BlocProvider.of(context);
}
