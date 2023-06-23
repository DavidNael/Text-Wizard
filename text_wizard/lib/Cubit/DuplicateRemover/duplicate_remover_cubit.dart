import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/DuplicateRemover/duplicate_remover_state.dart';

import '../../Components/custom_classes.dart';

class DuplicateRemoverCubit extends Cubit<DuplicateRemoverState> {
  DuplicateRemoverCubit() : super(DuplicateRemoverInitialState());
  static DuplicateRemoverCubit getCubit(context) => BlocProvider.of(context);
  double wordsToKeep = 0;

  void optionChange({required double value}) {
    wordsToKeep = value.roundToDouble();
    emit(DuplicateRemoverOptionChange());
  }

  String duplicateRemover({required String text}) {
    TextUtilities textUtil = TextUtilities();
    return textUtil.duplicateRemover(
      text: text,
      wordsToKeep: wordsToKeep,
    );
  }
}
