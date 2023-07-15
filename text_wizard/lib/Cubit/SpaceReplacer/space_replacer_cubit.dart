import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/SpaceReplacer/space_replacer_state.dart';

class SpaceReplacerCubit extends Cubit<SpaceReplacerState> {
  SpaceReplacerCubit() : super(SpaceReplacerInitialState());
  static SpaceReplacerCubit getCubit(context) => BlocProvider.of(context);

  String replaceSpaces({
    String text = "",
    String newKey = " ",
  }) {
    if (text.isNotEmpty) {
      newKey = newKey.replaceAll("\\n", "\n");
      return TextUtilities.replaceText(
        text: text,
        key: " ",
        newKey: newKey,
      );
    }
    return text;
  }
}
