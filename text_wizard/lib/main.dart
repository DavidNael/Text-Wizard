import 'Cubit/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Views/homepage.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_cubit.dart';
import 'package:text_wizard/Cubit/WordGenerator/word_generator_cubit.dart';
import 'package:text_wizard/Cubit/PasswordGenerator/password_generator_cubit.dart';
import 'package:text_wizard/Cubit/SentenceGenerator/sentence_generator_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
