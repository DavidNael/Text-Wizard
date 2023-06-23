import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/CaseConverter/case_converter_state.dart';

class CaseConverterCubit extends Cubit<CaseConverterState> {
  CaseConverterCubit() : super(CaseConverterInitialState());
  static CaseConverterCubit getCubit(context) => BlocProvider.of(context);
}
