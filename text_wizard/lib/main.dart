import 'package:tex_wiz/Cubit/DuplicateRemover/duplicate_remover_cubit.dart';
import 'package:tex_wiz/Cubit/TextSplitter/text_splitter_cubit.dart';
import 'package:tex_wiz/Cubit/WordTranslator/word_translator_cubit.dart';

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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
