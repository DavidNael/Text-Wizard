import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/SpaceIncreaser/space_increaser_state.dart';

import '../../Components/custom_classes.dart';

class SpaceIncreaserCubit extends Cubit<SpaceIncreaserState> {
  SpaceIncreaserCubit() : super(SpaceIncreaserInitialState());
  static SpaceIncreaserCubit getCubit(context) => BlocProvider.of(context);

  double spaceSliderValue = 1.0;
  void changeSpaceSliderValue({double value = 1}) {
    spaceSliderValue = value.roundToDouble();
    emit(SpaceIncreaserOptionChange());
  }

  bool ignoreSpaces = false;
  void changeIgnoreSpace() {
    ignoreSpaces = !ignoreSpaces;
    emit(SpaceIncreaserOptionChange());
  }

  String increaseSpaces({
    String text = "",
  }) {
    TextUtilities textUtilities = TextUtilities();
    if (text.isNotEmpty) {
      return textUtilities.spaceIncreaser(
        text: text,
        increaseValue: spaceSliderValue.toInt(),
        ignoreSpaces: ignoreSpaces,
      );
    }
    return text;
  }
}
