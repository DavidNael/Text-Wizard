import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextPrefixer/text_prefixer_state.dart';

class TextPrefixerCubit extends Cubit<TextPrefixerState> {
  TextPrefixerCubit() : super(TextPrefixerInitialState());
  static TextPrefixerCubit getCubit(context) => BlocProvider.of(context);
}
