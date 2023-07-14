import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/custom_classes.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_state.dart';
import 'package:tex_wiz/Views/anagram_generator_page.dart';
import 'package:tex_wiz/Views/text_formatter_page.dart';
import 'package:tex_wiz/Views/text_prefixer_page.dart';
import 'package:tex_wiz/Views/text_randomizer_page.dart';
import 'package:tex_wiz/Views/case_converter_page.dart';
import 'package:tex_wiz/Views/duplicate_remover_page.dart';
import 'package:tex_wiz/Views/line_limiter_page.dart';
import 'package:tex_wiz/Views/name_generator_page.dart';
import 'package:tex_wiz/Views/reverse_text_page.dart';
import 'package:tex_wiz/Views/text_remover_page.dart';
import 'package:tex_wiz/Views/space_increaser_page.dart';
import 'package:tex_wiz/Views/space_replacer_page.dart';
import 'package:tex_wiz/Views/text_replacer_page.dart';
import 'package:tex_wiz/Views/text_sorter_page.dart';
import 'package:tex_wiz/Views/text_splitter_page.dart';
import 'package:tex_wiz/Views/text_suffixer_page.dart';
import 'package:tex_wiz/Views/word_generator_page.dart';
import 'package:tex_wiz/Views/word_translator_page.dart';
import 'package:tex_wiz/Views/text_wrapper_page.dart';

import '../../Views/password_generator_page.dart';
import '../../Views/sentence_generator_page.dart';
import '../../Views/unicode_converter_page.dart';

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
      pageIcon2: Icons.numbers,
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
      pageWidget: const AnagramGeneratorPage(),
      pageIcon: Icons.factory,
      pageColor: Colors.blue.shade900,
    ),
  ];
  List<HomepageElement> textManipulationPages = [
    HomepageElement(
      pageName: "Case\nConverter",
      pageWidget: const CaseConverterPage(),
      pageIcon: Icons.text_fields,
      pageColor: Colors.deepPurple.shade700,
    ),
    HomepageElement(
      pageName: "Duplicate\nRemover",
      pageWidget: const DuplicateRemoverPage(),
      pageIcon: Icons.abc_rounded,
      pageIcon2: Icons.abc_rounded,
      pageColor: Colors.amber.shade800,
    ),
    HomepageElement(
      pageName: "Text\nRemover",
      pageWidget: const TextRemoverPage(),
      pageIcon: Icons.format_clear_rounded,
      pageColor: Colors.blue.shade800,
    ),
    HomepageElement(
      pageName: "Text\nSplitter",
      pageWidget: const TextSplitterPage(),
      pageIcon: Icons.call_split,
      pageColor: Colors.brown.shade800,
    ),
    HomepageElement(
      pageName: "Line\nLimiter",
      pageWidget: const LineLimiterPage(),
      pageIcon: Icons.format_list_numbered_outlined,
      pageColor: Colors.yellow.shade800,
    ),
    HomepageElement(
      pageName: "Reverse\nText",
      pageWidget: const ReverseTextPage(),
      pageIcon: Icons.fast_rewind_rounded,
      pageColor: Colors.lime.shade800,
    ),
    HomepageElement(
      pageName: "Space\nReplacer",
      pageWidget: const SpaceReplacerPage(),
      pageIcon: Icons.space_bar,
      pageColor: Colors.red.shade800,
    ),
    HomepageElement(
      pageName: "Space\nIncreaser",
      pageWidget: const SpaceIncreaserPage(),
      pageIcon: Icons.format_line_spacing_rounded,
      pageColor: Colors.pink.shade800,
    ),
    HomepageElement(
      pageName: "Text\nSorter",
      pageWidget: const TextSorterPage(),
      pageIcon: Icons.sort,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nRandomizer",
      pageWidget: const TextRandomizerPage(),
      pageIcon: Icons.shuffle_rounded,
      pageColor: Colors.green.shade500,
    ),
    HomepageElement(
      pageName: "Text\nFormatter",
      pageWidget: const TextFormatterPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nPrefixer",
      pageWidget: const TextPrefixerPage(),
      pageIcon: Icons.navigate_before,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nSuffixer",
      pageWidget: const TextSuffixerPage(),
      pageIcon: Icons.navigate_next,
      pageColor: Colors.teal.shade800,
    ),
    HomepageElement(
      pageName: "Text\nReplacer",
      pageWidget: const TextReplacerPage(),
      pageIcon: Icons.find_replace_rounded,
      pageColor: Colors.lightBlue.shade800,
    ),
    HomepageElement(
      pageName: "Unicode\nConverter",
      pageWidget: const UnicodeConverterPage(),
      pageIcon: Icons.text_increase,
      pageColor: Colors.grey.shade800,
    ),
    HomepageElement(
      pageName: "Text\nWrapper",
      pageWidget: const TextWrapperPage(),
      pageIcon: Icons.emoji_emotions,
      pageColor: Colors.teal.shade800,
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
