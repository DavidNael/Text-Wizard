import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/TextSplitter/text_splitter_state.dart';

class TextSplitterCubit extends Cubit<TextSplitterState> {
  TextSplitterCubit() : super(TextSplitterInitialState());
  static TextSplitterCubit getCubit(context) => BlocProvider.of(context);

  String textSplit({
    required String text,
    String replaceWithText = "\n",
    String textPrefix = "",
    String textSuffix = "",
    String textSplit = " ",
  }) {
    TextUtilities textUtil = TextUtilities();
    emit(TextSplitterGeneratingText());
    return textUtil.textSplitter(
      text: text,
      textSplit: textSplit,
      replaceWithText: replaceWithText,
      textPrefix: textPrefix,
      textSuffix: textSuffix,
    );
  }
}
