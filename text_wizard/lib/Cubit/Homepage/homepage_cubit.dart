import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_states.dart';

class HomepageCubit extends Cubit<HomepageStates> {
  HomepageCubit() : super(AppInitialState());

  static HomepageCubit getCubit(context) => BlocProvider.of(context);

  void openDrawer({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }
}
