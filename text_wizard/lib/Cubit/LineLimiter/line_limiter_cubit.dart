import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/LineLimiter/line_limiter_state.dart';

class LineLimiterCubit extends Cubit<LineLimiterState> {
  LineLimiterCubit() : super(LineLimiterInitialState());
  static LineLimiterCubit getCubit(context) => BlocProvider.of(context);
  bool shouldCutWord = false;
  double lineMax = 10;

  void setLineMax({required double newLineMax}) {
    lineMax = newLineMax.roundToDouble();
    emit(LineLimiterOptionChange());
  }

  void setShouldCutWord() {
    shouldCutWord = !shouldCutWord;
    emit(LineLimiterOptionChange());
  }

  String limitLine({String text = ""}) {
    return TextUtilities.lineLimiter(
      text: text,
      limit: lineMax.toInt(),
      shouldCutWord: shouldCutWord,
    );
  }
}
