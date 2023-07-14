import 'package:tex_wiz/Cubit/AnagramGenerator/anagram_generator_cubit.dart';
import 'package:tex_wiz/Cubit/CaseConverter/case_converter_cubit.dart';
import 'package:tex_wiz/Cubit/DuplicateRemover/duplicate_remover_cubit.dart';
import 'package:tex_wiz/Cubit/LineLimiter/line_limiter_cubit.dart';
import 'package:tex_wiz/Cubit/ReverseText/reverse_text_cubit.dart';
import 'package:tex_wiz/Cubit/TextRemover/text_remover_cubit.dart';
import 'package:tex_wiz/Cubit/SpaceIncreaser/space_increaser_cubit.dart';
import 'package:tex_wiz/Cubit/SpaceReplacer/space_replacer_cubit.dart';
import 'package:tex_wiz/Cubit/TextFormatter/text_formatter_cubit.dart';
import 'package:tex_wiz/Cubit/TextPrefixer/text_prefixer_cubit.dart';
import 'package:tex_wiz/Cubit/TextRandomizer/text_randomizer_cubit.dart';
import 'package:tex_wiz/Cubit/TextReplacer/text_replacer_cubit.dart';
import 'package:tex_wiz/Cubit/TextSorter/text_sorter_cubit.dart';
import 'package:tex_wiz/Cubit/TextSplitter/text_splitter_cubit.dart';
import 'package:tex_wiz/Cubit/TextSuffixer/text_suffixer_cubit.dart';
import 'package:tex_wiz/Cubit/UnicodeConverter/unicode_converter_cubit.dart';
import 'package:tex_wiz/Cubit/WordTranslator/word_translator_cubit.dart';
import 'package:tex_wiz/Cubit/WordWrapper/word_wrapper_cubit.dart';
import 'Cubit/NameGenerator/name_generator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Views/homepage.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_cubit.dart';
import 'package:tex_wiz/Cubit/WordGenerator/word_generator_cubit.dart';
import 'package:tex_wiz/Cubit/PasswordGenerator/password_generator_cubit.dart';
import 'package:tex_wiz/Cubit/SentenceGenerator/sentence_generator_cubit.dart';

import 'Cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomepageCubit(),
        ),
        BlocProvider(
          create: (context) => WordGeneratorCubit(),
        ),
        BlocProvider(
          create: (context) => SentenceGeneratorCubit(),
        ),
        BlocProvider(
          create: (context) => PasswordGeneratorCubit(),
        ),
        BlocProvider(
          create: (context) => NameGeneratorCubit(),
        ),
        BlocProvider(
          create: (context) => TextSplitterCubit(),
        ),
        BlocProvider(
          create: (context) => WordTranslatorCubit(),
        ),
        BlocProvider(
          create: (context) => DuplicateRemoverCubit(),
        ),
        BlocProvider(
          create: (context) => AnagramGeneratorCubit(),
        ),
        BlocProvider(
          create: (context) => CaseConverterCubit(),
        ),
        BlocProvider(
          create: (context) => LineLimiterCubit(),
        ),
        BlocProvider(
          create: (context) => ReverseTextCubit(),
        ),
        BlocProvider(
          create: (context) => TextRemoverCubit(),
        ),
        BlocProvider(
          create: (context) => SpaceReplacerCubit(),
        ),
        BlocProvider(
          create: (context) => SpaceIncreaserCubit(),
        ),
        BlocProvider(
          create: (context) => TextSorterCubit(),
        ),
        BlocProvider(
          create: (context) => TextRandomizerCubit(),
        ),
        BlocProvider(
          create: (context) => TextFormatterCubit(),
        ),
        BlocProvider(
          create: (context) => TextPrefixerCubit(),
        ),
        BlocProvider(
          create: (context) => TextSuffixerCubit(),
        ),
        BlocProvider(
          create: (context) => TextReplacerCubit(),
        ),
        BlocProvider(
          create: (context) => UnicodeConverterCubit(),
        ),
        BlocProvider(
          create: (context) => WordWrapperCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
