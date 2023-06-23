import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/LineLimiter/line_limiter_state.dart';

class LineLimiterCubit extends Cubit<LineLimiterState> {
  LineLimiterCubit() : super(LineLimiterInitialState());
  static LineLimiterCubit getCubit(context) => BlocProvider.of(context);
}
