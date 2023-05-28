import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/functions.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Cubit/SentenceGenerator/sentence_generator_cubit.dart';
import 'package:word_generator/word_generator.dart';

class SentenceGeneratorPage extends StatelessWidget {
  const SentenceGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    WordGenerator();
    return BlocConsumer<SentenceGeneratorCubit, SentenceGeneratorState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SentenceGeneratorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: CustomScrollView(
            slivers: [
              // 1 AppBar
              SliverAppBar(
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
                floating: true,
                snap: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Form(
                        child: Column(
                          children: [
                            //1 Results Container
                            Container(
                              height: 200,
                              decoration: customBoxDecoration(
                                boxTopLeftBorderRadius: 25,
                                boxBottomRightBorderRadius: 25,
                                hasBorder: true,
                                borderWidth: 0.5,
                                borderColor: Colors.grey.withAlpha(100),
                                hasShadow: true,
                                shadowAlphaColor: 150,
                                shadowBlurRadius: 0.1,
                                shadowOffset: const Offset(3, 2),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // 2 Container Header Row
                                  Row(
                                    children: [
                                      // Results Text
                                      const Expanded(
                                        child: Text(
                                          "Results:",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      // Copy To Clipboard Button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            copyToClipboard(
                                              text: cubit.sentence,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.copy,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      // Share Button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            shareText(
                                              text: cubit.sentence,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.share,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  cubit.sentence == ""
                                      ?
                                      // 2 Show No Results Text
                                      Expanded(
                                          child: Center(
                                            child: Text(
                                              "No results available...",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ),
                                        )
                                      :
                                      // 2 Show Sentence Results
                                      Expanded(
                                          child: SingleChildScrollView(
                                            child: customMaterialButton(
                                              height: null,
                                              text: cubit.sentence,
                                              fontSize: 20,
                                              onPressed: () {
                                                copyToClipboard(
                                                  text: cubit.sentence,
                                                );
                                              },
                                              maxLines: null,
                                              horizontalPadding: 10,
                                              boxTopLeftBorderRadius: 25,
                                              boxBottomRightBorderRadius: 25,
                                              hasGradient: true,
                                              gradientColors: [
                                                Colors.blue.shade500,
                                                Colors.indigo.shade600,
                                              ],
                                              hasShadow: true,
                                              shadowAlphaColor: 150,
                                              shadowBlurRadius: 0.5,
                                              shadowOffset: const Offset(3, 2),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            // 1 Modifiers Container
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Container(
                                decoration: customBoxDecoration(
                                  boxTopLeftBorderRadius: 25,
                                  boxBottomRightBorderRadius: 25,
                                  hasBorder: true,
                                  borderWidth: 0.5,
                                  borderColor: Colors.grey.withAlpha(100),
                                  hasShadow: true,
                                  shadowAlphaColor: 150,
                                  shadowBlurRadius: 0.1,
                                  shadowOffset: const Offset(3, 2),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  children: [
                                    // 2 Sentence Length Slider
                                    customSlider(
                                      title:
                                          "Sentence Length: ${cubit.sentenceWordsSliderValue.toInt()}",
                                      value: cubit.sentenceWordsSliderValue,
                                      onChanged: (newValue) {
                                        cubit.changeSlider(
                                          newValue: newValue.roundToDouble(),
                                          sliderId: 0,
                                        );
                                      },
                                      hasBorder: true,
                                      borderColor:
                                          Colors.grey.shade500.withAlpha(190),
                                      horizontalPadding: 10,
                                      minValue: 0,
                                      maxValue: 200,
                                    ),
                                    // 2 Sentence Line Size Slider
                                    customSlider(
                                      hasBorder: true,
                                      borderColor:
                                          Colors.grey.shade500.withAlpha(190),
                                      title:
                                          "Max Words Per Line: ${cubit.sentenceLinesSliderValue.toInt()}",
                                      value: cubit.sentenceLinesSliderValue,
                                      onChanged: (newValue) {
                                        cubit.changeSlider(
                                          newValue: newValue.roundToDouble(),
                                          sliderId: 1,
                                        );
                                      },
                                      horizontalPadding: 10,
                                      minValue: 0,
                                    ),

                                    // 2 Word type Selection
                                    customTextDropDownMenu(
                                      borderColor: Colors.black.withAlpha(150),
                                      borderWidth: 0.3,
                                      boxTopLeftBorderRadius: 15,
                                      boxBottomRightBorderRadius: 15,
                                      selectedValue: cubit.wordTypeValue,
                                      hasShadow: true,
                                      shadowAlphaColor: 150,
                                      shadowBlurRadius: 0.1,
                                      items: [
                                        const DropdownMenuItem(
                                          value: 0,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text('All Words')),
                                        ),
                                        const DropdownMenuItem(
                                          value: 1,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text('Nouns')),
                                        ),
                                        const DropdownMenuItem(
                                          value: 2,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text('Adjectives')),
                                        ),
                                        const DropdownMenuItem(
                                          value: 3,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text('Verbs')),
                                        ),
                                        const DropdownMenuItem(
                                          value: 4,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text('Adverbs')),
                                        ),
                                      ],
                                      onChanged: (newValue) {
                                        cubit.changeWordType(
                                            newValue: newValue ??= 0);
                                      },
                                    ),

                                    // 2 Safe Search Checkbox
                                    customCheckbox(
                                      text: "Safe Search",
                                      isActive: cubit.checkboxOptions[0],
                                      onTap: () {
                                        cubit.changeCheckBoxType(
                                            optionNumber: 0);
                                      },
                                    ),

                                    // 2 Generate Button
                                    customMaterialButton(
                                      text: "Generate",
                                      onPressed: () {
                                        cubit.generateSentence(
                                          wordType: cubit.wordTypeValue,
                                          sentenceLength: cubit
                                              .sentenceWordsSliderValue
                                              .toInt(),
                                          sentenceLines: cubit
                                              .sentenceLinesSliderValue
                                              .toInt(),
                                        );
                                      },
                                      verticalPadding: 10,
                                      hasGradient: true,
                                      gradientColors: [
                                        Colors.blue.shade500,
                                        Colors.indigo.shade600,
                                      ],
                                      hasShadow: true,
                                      shadowAlphaColor: 150,
                                      shadowBlurRadius: 0.5,
                                      shadowOffset: const Offset(3, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
