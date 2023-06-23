import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/TextSorter/text_sorter_state.dart';

class TextSorterCubit extends Cubit<TextSorterState> {
  TextSorterCubit() : super(TextSorterInitialState());
  static TextSorterCubit getCubit(context) => BlocProvider.of(context);
}
