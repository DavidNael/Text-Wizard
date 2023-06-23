import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/SpaceReplacer/space_replacer_state.dart';

class SpaceReplacerCubit extends Cubit<SpaceReplacerState> {
  SpaceReplacerCubit() : super(SpaceReplacerInitialState());
  static SpaceReplacerCubit getCubit(context) => BlocProvider.of(context);
}
