import 'password_generator copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Views/word_generator.dart';
import 'package:text_wizard/Views/sentence_generator.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_cubit.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    return BlocConsumer<HomepageCubit, HomepageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomepageCubit.getCubit(mainContext);
        return Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.black.withAlpha(50),
          ),
          body: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: customBoxDecoration(
                  boxBottomLeftBorderRadius: 20,
                  boxBottomRightBorderRadius: 20,
                  hasShadow: true,
                  shadowBlurRadius: 20,
                  shadowSpreadRadius: 20,
                  shadowColor: Colors.grey,
                  hasGradient: true,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        //1 Menu Icon
                        Align(
                          alignment: Alignment.topLeft,
                          child: Builder(
                            builder: (context) {
                              return customIconWidget(
                                color: Colors.white,
                                icon: Icons.menu,
                                size: 35,
                                onPressed: () {
                                  cubit.openDrawer(context: context);
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //1 Avatar
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    size: 90,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              //1 Username
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back..",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "David Nael",
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 0.85,
                  crossAxisCount: 3,
                  children: [
                    homeIcon(
                      context: context,
                      title: "Word Generator",
                      color: Colors.blue,
                      icon: Icons.numbers,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Sentence Generator",
                      color: Colors.green.shade800,
                      icon: Icons.numbers,
                      navigatePage: const SentenceGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Password Generator",
                      color: Colors.red,
                      icon: Icons.password,
                      navigatePage: const PasswordGenerator2Page(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Name Generator",
                      color: Colors.pink,
                      icon: Icons.abc,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Language Translation",
                      color: Colors.orange,
                      icon: Icons.translate,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Anagram Generator", //1 Example: Dog->God
                      color: Colors.blue.shade900,
                      icon: Icons.factory,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Emoji Search",
                      color: Colors.teal.shade800,
                      icon: Icons.emoji_emotions,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Case Converter",
                      color: Colors.deepPurple.shade700,
                      icon: Icons.text_fields,
                      navigatePage: const WordGeneratorPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Unicode Converter",
                      color: Colors.grey.shade800,
                      icon: Icons.text_increase,
                      navigatePage: const WordGeneratorPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
