import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/ReverseText/reverse_text_state.dart';

class ReverseTextCubit extends Cubit<ReverseTextState> {
  ReverseTextCubit() : super(ReverseTextInitialState());
  static ReverseTextCubit getCubit(context) => BlocProvider.of(context);
}
