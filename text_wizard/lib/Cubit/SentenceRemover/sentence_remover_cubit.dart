import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Cubit/SentenceRemover/sentence_remover_state.dart';

class SentenceRemoverCubit extends Cubit<SentenceRemoverState> {
  SentenceRemoverCubit() : super(SentenceRemoverInitialState());
  static SentenceRemoverCubit getCubit(context) => BlocProvider.of(context);
}
