import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextFormatter/text_formatter_state.dart';

class TextFormatterCubit extends Cubit<TextFormatterState> {
  TextFormatterCubit() : super(TextFormatterInitialState());
  static TextFormatterCubit getCubit(context) => BlocProvider.of(context);
  String textFormat({String text = ""}) {
    TextUtilities textUtilities = TextUtilities();
    if (text.isNotEmpty) {
      return textUtilities.formatText(text: text);
    }
    return text;
  }
}
