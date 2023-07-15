import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextReplacer/text_replacer_state.dart';

class TextReplacerCubit extends Cubit<TextReplacerState> {
  TextReplacerCubit() : super(TextReplacerInitialState());
  static TextReplacerCubit getCubit(context) => BlocProvider.of(context);
  bool caseSensitive = false;

  void changeCaseSensitive() {
    caseSensitive = !caseSensitive;
    emit(TextReplacerOptionChange());
  }

  String replaceText({
    String text = "",
    String key = "",
    String newKey = "",
  }) {
    if (text.isNotEmpty && newKey.isNotEmpty) {
      return TextUtilities.replaceText(
        text: text,
        key: key,
        newKey: newKey,
        caseSensitive: caseSensitive,
      );
    }
    return text;
  }
}
