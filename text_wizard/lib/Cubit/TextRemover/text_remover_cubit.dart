import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextRemover/text_remover_state.dart';

class TextRemoverCubit extends Cubit<TextRemoverState> {
  TextRemoverCubit() : super(TextRemoverInitialState());
  static TextRemoverCubit getCubit(context) => BlocProvider.of(context);
  Map<String, bool> options = {
    'caseSensitive': false,
    'matchKey': false,
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  String keyword = '';

  void changeCheckboxValue({String key = "reverseCharacters"}) {
    options[key] = !options[key]!;
    emit(TextRemoverOptionChange());
  }

  String textRemover({
    String text = "",
    String keyword = "",
  }) {
    TextUtilities textUtilities = TextUtilities();
    String result = text;
    if (text.isNotEmpty && keyword.isNotEmpty) {
      result = textUtilities.textRemover(
        text: text,
        key: keyword,
        caseSensitive: options['caseSensitive']!,
        matchKey: options['matchKey']!,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
    return result;
  }
}
