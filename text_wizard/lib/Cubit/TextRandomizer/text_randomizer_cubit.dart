import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextRandomizer/text_randomizer_state.dart';

import '../../Components/custom_classes.dart';

class TextRandomizerCubit extends Cubit<TextRandomizerState> {
  TextRandomizerCubit() : super(TextRandomizerInitialState());
  static TextRandomizerCubit getCubit(context) => BlocProvider.of(context);
  Map<String, bool> options = {
    'ignoreSpaces': false,
    'ignoreNewLines': false,
  };
  void setOption({String option = "ignoreSpaces"}) {
    options[option] = !options[option]!;
    emit(TextRandomizerOptionChange());
  }

  String textRandomizer({
    String text = '',
  }) {
    TextUtilities textUtilities = TextUtilities();
    if (text.isNotEmpty) {
      return textUtilities.textRandomizer(
        text: text,
        ignoreSpaces: options['ignoreSpaces']!,
        ignoreNewLines: options['ignoreNewLines']!,
      );
    }
    return text;
  }
}
