import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tex_wiz/Components/functions.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';
import 'package:tex_wiz/Cubit/WordGenerator/word_generator_cubit.dart';

import '../Constants/colors.dart';

class WordGeneratorPage extends StatelessWidget {
  const WordGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController startWithController = TextEditingController();
    TextEditingController endWithController = TextEditingController();
    FocusNode startWithFocusNode = FocusNode();
    FocusNode endWithFocusNode = FocusNode();

    return BlocConsumer<WordGeneratorCubit, WordGeneratorState>(
      listener: (context, state) {
        if (state is WordGeneratorGeneratingWords) {
          customLoadingDialog(context: context);
        }
        if (state is WordGeneratorFinishedGeneratingWords) {
          Navigator.pop(context);
        }
        if (state is WordGeneratorGeneratedFewWords) {
          Fluttertoast.showToast(
            msg: "Couldn't generate all words.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        }
        if (state is WordGeneratorGeneratedNoWords) {
          Fluttertoast.showToast(
            msg: "No words available.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        final cubit = WordGeneratorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              // 1 AppBar
              customAppbar(context: context, title: "Word Generator"),

              // 1 Body
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startWithFocusNode.unfocus();
                          endWithFocusNode.unfocus();
                        },
                        child: Column(
                          children: [
                            // 1 Results Container
                            Container(
                              height: 200,
                              decoration: customBoxDecoration(
                                boxTopLeftBorderRadius: 25,
                                boxBottomRightBorderRadius: 25,
                                hasBorder: true,
                                borderWidth: 0.5,
                                borderColor: greyBorderColor,
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
                                              text: cubit.words.join("\n"),
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
                                              text: cubit.words.join("\n"),
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
                                  // 2 Show Results List
                                  Visibility(
                                    visible: cubit.words.isNotEmpty,
                                    child: Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.words.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: customMaterialButton(
                                              text: cubit.words[index],
                                              fontSize: 20,
                                              onPressed: () {
                                                copyToClipboard(
                                                  text: cubit.words[index],
                                                );
                                              },
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
                                          );
                                        },
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
                                borderColor: greyBorderColor,
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
                                  //2 Begin - End Of Word Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // 3 Begin Of Word Field
                                      Expanded(
                                        child: customTextFormField(
                                          controller: startWithController,
                                          focusNode: startWithFocusNode,
                                          label: "Start With",
                                          hint: "Optional",
                                          verticalPadding: 10,
                                          boxTopLeftBorderRadius: 15,
                                          boxBottomRightBorderRadius: 15,
                                          borderWidth: 0.5,
                                          borderColor:
                                              Colors.black.withAlpha(150),
                                          borderFocusedWidth: 0.5,
                                          focusBorderColor:
                                              Colors.black.withAlpha(150),
                                          hasShadow: true,
                                          shadowAlphaColor: 150,
                                          shadowBlurRadius: 0.1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // 3 End Of Word Field
                                      Expanded(
                                        child: customTextFormField(
                                          controller: endWithController,
                                          focusNode: endWithFocusNode,
                                          label: "End With",
                                          hint: "Optional",
                                          verticalPadding: 10,
                                          boxTopLeftBorderRadius: 15,
                                          boxBottomRightBorderRadius: 15,
                                          borderWidth: 0.5,
                                          borderColor:
                                              Colors.black.withAlpha(150),
                                          borderFocusedWidth: 0.5,
                                          focusBorderColor:
                                              Colors.black.withAlpha(150),
                                          hasShadow: true,
                                          shadowAlphaColor: 150,
                                          shadowBlurRadius: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // 2 Length - Count Of Word Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // 3 Length Of Word Slider
                                      Expanded(
                                        child: customSlider(
                                          hasBorder: true,
                                          borderColor: Colors.grey.shade500
                                              .withAlpha(190),
                                          title:
                                              "Word Length: ${cubit.wordLengthSlider.toInt() == 0 ? "Any" : cubit.wordLengthSlider.toInt()}",
                                          value: cubit.wordLengthSlider,
                                          onChanged: (newValue) {
                                            cubit.changeSlider(
                                              newValue:
                                                  newValue.roundToDouble(),
                                              sliderId: 0,
                                            );
                                          },
                                          minValue: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // 3 Count Of Word Slider
                                      Expanded(
                                        child: customSlider(
                                          borderColor: Colors.grey.shade500
                                              .withAlpha(190),
                                          title:
                                              "Word Count: ${cubit.wordCountSlider.toInt()}",
                                          value: cubit.wordCountSlider,
                                          onChanged: (newValue) {
                                            cubit.changeSlider(
                                              newValue:
                                                  newValue.roundToDouble(),
                                              sliderId: 1,
                                            );
                                          },
                                          maxValue: 300,
                                        ),
                                      ),
                                    ],
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
                                            child:
                                                customText(text: 'All Words')),
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
                                            child:
                                                customText(text: 'Adjectives')),
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
                                      cubit.changeCheckBoxType(
                                        optionNumber: 0,
                                      );
                                    },
                                  ),

                                  // 2 Generate Button
                                  customMaterialButton(
                                    text: "Generate",
                                    width: double.infinity,
                                    onPressed: () {
                                      startWithFocusNode.unfocus();
                                      endWithFocusNode.unfocus();
                                      FocusScope.of(context).unfocus();
                                      cubit.generateWords(
                                        startWith: startWithController.text,
                                        endsWith: endWithController.text,
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
