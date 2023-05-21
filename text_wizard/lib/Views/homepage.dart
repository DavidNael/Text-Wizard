import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_cubit.dart';
import 'package:text_wizard/Cubit/Homepage/homepage_states.dart';
import 'package:text_wizard/Views/random_word.dart';
import 'package:text_wizard/Widgets/ui_widgets.dart';

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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withAlpha(150),
                      Colors.indigo.shade400,
                      Colors.indigo.shade600,
                      Colors.indigo.shade800,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.grey,
                      spreadRadius: 20,
                    )
                  ],
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
                                    )),
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
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Sentence Generator",
                      color: Colors.green.shade800,
                      icon: Icons.numbers,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Password Generator",
                      color: Colors.red,
                      icon: Icons.password,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Name Generator",
                      color: Colors.pink,
                      icon: Icons.abc,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Language Translation",
                      color: Colors.orange,
                      icon: Icons.translate,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Anagram Generator", //1 Example: Dog->God
                      color: Colors.blue.shade900,
                      icon: Icons.factory,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Emoji Search",
                      color: Colors.teal.shade800,
                      icon: Icons.emoji_emotions,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Case Converter",
                      color: Colors.deepPurple.shade700,
                      icon: Icons.text_fields,
                      navigatePage: const RandomWordPage(),
                    ),
                    homeIcon(
                      context: context,
                      title: "Unicode Converter",
                      color: Colors.grey.shade800,
                      icon: Icons.text_increase,
                      navigatePage: const RandomWordPage(),
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
