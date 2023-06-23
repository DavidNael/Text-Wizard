import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/SpaceIncreaser/space_increaser_state.dart';

class SpaceIncreaserCubit extends Cubit<SpaceIncreaserState> {
  SpaceIncreaserCubit() : super(SpaceIncreaserInitialState());
  static SpaceIncreaserCubit getCubit(context) => BlocProvider.of(context);
}
