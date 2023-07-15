import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/ReverseText/reverse_text_state.dart';

class ReverseTextCubit extends Cubit<ReverseTextState> {
  ReverseTextCubit() : super(ReverseTextInitialState());
  static ReverseTextCubit getCubit(context) => BlocProvider.of(context);
  Map<String, bool> options = {
    'reverseCharacters': false,
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void changeCheckboxValue({String key = "reverseCharacters"}) {
    options[key] = !options[key]!;
    emit(ReverseTextOptionChange());
  }

  String reverseText({String text = ''}) {
    if (text.isNotEmpty) {
      return TextUtilities.reverseText(
        text: text,
        reverseCharacters: options['reverseCharacters']!,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
    return '';
  }
}
