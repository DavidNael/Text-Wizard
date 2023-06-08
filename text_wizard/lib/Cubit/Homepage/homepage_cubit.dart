import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_state.dart';
import 'package:tex_wiz/Views/name_generator_page.dart';
import 'package:tex_wiz/Views/word_generator_page.dart';

import '../../Views/password_generator_page.dart';
import '../../Views/sentence_generator_page.dart';

class HomepageCubit extends Cubit<HomepageStates> {
  HomepageCubit() : super(HomepageInitialState());

  List<HomepageElement> pages = [
    HomepageElement(
      pageName: "Word\nGenerator",
      pageWidget: const WordGeneratorPage(),
      pageIcon: Icons.numbers,
      pageColor: Colors.blue,
    ),
    HomepageElement(
      pageName: "Sentence\nGenerator",
      pageWidget: const SentenceGeneratorPage(),
      pageIcon: Icons.numbers,
      pageColor: Colors.green.shade800,
    ),
    HomepageElement(
      pageName: "Password\nGenerator",
      pageWidget: const PasswordGeneratorPage(),
      pageIcon: Icons.password,
      pageColor: Colors.red,
    ),
    HomepageElement(
      pageName: "Name\nGenerator",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.abc,
      pageColor: Colors.pink,
    ),
    HomepageElement(
      pageName: "Language\nTranslation",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.translate,
      pageColor: Colors.orange,
    ),
    HomepageElement(
      pageName: "Anagram\nGenerator",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.factory,
      pageColor: Colors.blue.shade900,
    ),
    HomepageElement(
      pageName: "Emoji\nSearch",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Case\nConverter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_fields,
      pageColor: Colors.deepPurple.shade700,
    ),
    HomepageElement(
      pageName: "Unicode\nConverter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
  ];

  static HomepageCubit getCubit(context) => BlocProvider.of(context);

  void openDrawer({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }
}
