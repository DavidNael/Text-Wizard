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
              customAppbar(context: context, title: "Sentence Generator"),

              // 1 Body
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                                  // 3 Results Text
                                  Expanded(
                                    child: customText(
                                      text: "Results:",
                                      isBold: true,
                                      fontSize: 25,
                                    ),
                                  ),
                                  // 3 Copy To Clipboard Button
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
                                  // 3 Share Button
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

                              // 2 Show Sentence Results
                              Visibility(
                                visible: cubit.sentence.isNotEmpty,
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    child: Center(
                                      child: customMaterialButton(
                                        verticalPadding: 20,
                                        height: null,
                                        text: cubit.sentence,
                                        fontSize: 20,
                                        onPressed: () {
                                          copyToClipboard(
                                            text: cubit.sentence,
                                          );
                                        },
                                        maxLines: null,
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 1 Modifiers Container
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              // 2 Sentence Length Slider
                              customSlider(
                                title:
                                    "Sentence Words: ${cubit.sentenceWordsSliderValue.toInt()}",
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
                                minValue: 5,
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
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: customText(text: 'All Words')),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: customText(text: 'Nouns')),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: customText(text: 'Adjectives')),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: customText(text: 'Verbs')),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: customText(text: 'Adverbs')),
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
                                  cubit.changeCheckBoxValue(
                                    checkboxNumber: 0,
                                  );
                                },
                              ),
                              // 2 Add Commas Checkbox
                              customCheckbox(
                                text: "Add Commas",
                                isActive: cubit.checkboxOptions[1],
                                onTap: () {
                                  cubit.changeCheckBoxValue(
                                    checkboxNumber: 1,
                                  );
                                },
                              ),

                              // 2 Generate Button
                              customMaterialButton(
                                text: "Generate",
                                onPressed: () {
                                  cubit.generateSentence(
                                    wordType: cubit.wordTypeValue,
                                    sentenceLength:
                                        cubit.sentenceWordsSliderValue.toInt(),
                                    sentenceLines:
                                        cubit.sentenceLinesSliderValue.toInt(),
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
                      ],
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
