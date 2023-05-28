import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Cubit/SentenceGenerator/sentence_generator_cubit.dart';

class SentenceGeneratorPage extends StatelessWidget {
  const SentenceGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SentenceGeneratorCubit, SentenceGeneratorState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SentenceGeneratorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade800.withAlpha(0),
            shadowColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 200,
            flexibleSpace: ClipPath(
              clipper: WavyAppBarClipper(),
              child: Container(
                decoration: customBoxDecoration(
                  hasGradient: true,
                ),
              ),
            ),
            title: const Text("𝗦𝗲𝗻𝘁𝗲𝗻𝗰𝗲 𝗚𝗲𝗻𝗲𝗿𝗮𝘁𝗼𝗿"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            child: Column(
              children: [
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: customBoxDecoration(),
                    child: Column(
                      children: [
                        //1 Sentence Length
                        customSlider(
                          borderColor: Colors.grey.shade500.withAlpha(190),
                          title:
                              "Sentence Length: ${cubit.sliderValue.toInt()}",
                          value: cubit.sliderValue,
                          onChanged: (newValue) {
                            cubit.changeSlider(
                                newValue: newValue.roundToDouble());
                          },
                          verticalPadding: 20,
                        ),

                        //1 Word type Selection
                        customTextDropDownMenu(
                          borderColor: Colors.black.withAlpha(150),
                          borderWidth: 0.3,
                          borderRadius: 10,
                          selectedValue: cubit.wordTypeValue,
                          items: [
                            const DropdownMenuItem(
                              value: 0,
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('All Words')),
                            ),
                            const DropdownMenuItem(
                              value: 1,
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('Verbs')),
                            ),
                            const DropdownMenuItem(
                              value: 2,
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text('Nouns')),
                            ),
                          ],
                          onChanged: (newValue) {
                            cubit.changeWordType(newValue: newValue ??= 0);
                          },
                        ),

                        //1 Confirmation Button
                        customMaterialButton(
                          text: "Generate",
                          onPressed: () {},
                          // padding: 20,
                          hasGradient: true,
                          gradientColors: [
                            Colors.blue,
                            Colors.blue,
                            Colors.blue.shade400,
                            Colors.blue.shade600,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //1 Results
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      decoration: customBoxDecoration(
                        hasBorder: true,
                        borderWidth: 0.5,
                        borderColor: Colors.grey.withAlpha(100),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: customBoxDecoration(
                                hasGradient: true,
                              ),
                              child: Center(
                                child: Text(
                                  "Placeholder $index",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
