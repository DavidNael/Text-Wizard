import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/UnicodeConverter/unicode_converter_state.dart';

class UnicodeConverterCubit extends Cubit<UnicodeConverterState> {
  UnicodeConverterCubit() : super(UnicodeConverterInitialState());
  static UnicodeConverterCubit getCubit(context) => BlocProvider.of(context);
}
