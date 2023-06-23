import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_state.dart';
import 'package:tex_wiz/Views/duplicate_remover_page.dart';
import 'package:tex_wiz/Views/name_generator_page.dart';
import 'package:tex_wiz/Views/text_splitter_page.dart';
import 'package:tex_wiz/Views/word_generator_page.dart';
import 'package:tex_wiz/Views/word_translator_page.dart';

import '../../Views/password_generator_page.dart';
import '../../Views/sentence_generator_page.dart';

class HomepageCubit extends Cubit<HomepageStates> {
  HomepageCubit() : super(HomepageInitialState());

  List<HomepageElement> textGenerationPages = [
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
      pageName: "Anagram\nGenerator",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.factory,
      pageColor: Colors.blue.shade900,
    ),
  ];
  List<HomepageElement> textAnalysisPages = [
    HomepageElement(
      pageName: "Language\nTranslation",
      pageWidget: const WordTranslatorPage(),
      pageIcon: Icons.translate,
      pageColor: Colors.orange,
    ),
    HomepageElement(
      pageName: "Emoji\nSearch",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Word\nCounter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.orange.shade800,
    ),
    HomepageElement(
      pageName: "Line\nExtractor",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.line_axis,
      pageColor: Colors.purple.shade800,
    ),
  ];
  List<HomepageElement> textManipulationPages = [
    HomepageElement(
      pageName: "Case\nConverter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_fields,
      pageColor: Colors.deepPurple.shade700,
    ),
    HomepageElement(
      pageName: "Duplicate\nRemover",
      pageWidget: const DuplicateRemoverPage(),
      pageIcon: Icons.format_strikethrough_outlined,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nSplitter",
      pageWidget: const TextSplitterPage(),
      pageIcon: Icons.text_snippet,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Line\nLimiter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Reverse\nText",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Sentence\nRemover",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Space\nReplacer",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Space\nIncreaser",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nSorter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nRandomizer",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nFormatter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nPrefixer",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nReplacer",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Unicode\nConverter",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Word\nWrapper",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
  ];
  List<HomepageElement> encodingDecodingPages = [
    HomepageElement(
      pageName: "Text\nDecoder-Encoder",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Morse\nDecoder-Encoder",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Base64\nDecoder-Encoder",
      pageWidget: const NameGeneratorPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Decimal\nDecoder-Encoder",
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
