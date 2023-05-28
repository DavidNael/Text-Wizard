import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:text_wizard/Components/functions.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Cubit/WordGenerator/word_generator_cubit.dart';

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
            title: const Text("𝗪𝗼𝗿𝗱 𝗚𝗲𝗻𝗲𝗿𝗮𝘁𝗼𝗿"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  startWithFocusNode.unfocus();
                  endWithFocusNode.unfocus();
                },
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
                                        text: cubit.words.join("\n"),
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

                            cubit.words.isEmpty
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
                                // 2 Show Results List
                                Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cubit.words.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: customMaterialButton(
                                            text: cubit.words[index],
                                            fontSize: 30,
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
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
                                      horizontalPadding: 10,
                                      verticalPadding: 10,
                                      boxTopLeftBorderRadius: 15,
                                      boxBottomRightBorderRadius: 15,
                                      borderWidth: 0.5,
                                      borderColor: Colors.black.withAlpha(150),
                                      borderFocusedWidth: 0.5,
                                      focusBorderColor:
                                          Colors.black.withAlpha(150),
                                      hasShadow: true,
                                      shadowAlphaColor: 150,
                                      shadowBlurRadius: 0.1,
                                    ),
                                  ),
                                  // 3 End Of Word Field
                                  Expanded(
                                    child: customTextFormField(
                                      controller: endWithController,
                                      focusNode: endWithFocusNode,
                                      label: "End With",
                                      horizontalPadding: 10,
                                      verticalPadding: 10,
                                      boxTopLeftBorderRadius: 15,
                                      boxBottomRightBorderRadius: 15,
                                      borderWidth: 0.5,
                                      borderColor: Colors.black.withAlpha(150),
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
                                      borderColor:
                                          Colors.grey.shade500.withAlpha(190),
                                      title:
                                          "Word Length: ${cubit.wordLengthSlider.toInt()}",
                                      value: cubit.wordLengthSlider,
                                      onChanged: (newValue) {
                                        cubit.changeSlider(
                                          newValue: newValue.roundToDouble(),
                                          sliderId: 0,
                                        );
                                      },
                                      horizontalPadding: 10,
                                      minValue: 0,
                                    ),
                                  ),
                                  // 3 Count Of Word Slider
                                  Expanded(
                                    child: customSlider(
                                      borderColor:
                                          Colors.grey.shade500.withAlpha(190),
                                      title:
                                          "Word Count: ${cubit.wordCountSlider.toInt()}",
                                      value: cubit.wordCountSlider,
                                      onChanged: (newValue) {
                                        cubit.changeSlider(
                                          newValue: newValue.roundToDouble(),
                                          sliderId: 1,
                                        );
                                      },
                                      verticalPadding: 10,
                                      horizontalPadding: 10,
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

                              // 2 Generate Button
                              customMaterialButton(
                                text: "Generate",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
