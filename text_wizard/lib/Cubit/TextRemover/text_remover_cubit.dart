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
    String result = text;
    print("Test bef: $result");
    if (text.isNotEmpty ) {
      result = TextUtilities.textRemover(
        text: text,
        key: keyword,
        caseSensitive: options['caseSensitive']!,
        matchKey: options['matchKey']!,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
    print("Test after: $result");
    return result;
  }
}
