import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/1Generic/state.dart';

class TempCubit extends Cubit<TempState> {
  TempCubit() : super(TempInitialState());
  static TempCubit getCubit(context) => BlocProvider.of(context);
}
