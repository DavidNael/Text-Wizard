import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextFormatter/text_formatter_state.dart';

class TextFormatterCubit extends Cubit<TextFormatterState> {
  TextFormatterCubit() : super(TextFormatterInitialState());
  static TextFormatterCubit getCubit(context) => BlocProvider.of(context);
}
