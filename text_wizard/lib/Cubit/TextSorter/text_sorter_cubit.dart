import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextSorter/text_sorter_state.dart';

class TextSorterCubit extends Cubit<TextSorterState> {
  TextSorterCubit() : super(TextSorterInitialState());
  static TextSorterCubit getCubit(context) => BlocProvider.of(context);
  Map<String, bool> options = {
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void setOption({String option = "ignoreSpaces"}) {
    options[option] = !options[option]!;
    emit(TextSorterOptionChange());
  }

  String textSorter({
    String text = '',
  }) {
    if (text.isNotEmpty) {
      return TextUtilities.textSorter(
        text: text,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
        
      );
    }
    return text;
  }
}
