import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/functions.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Cubit/WordGenerator/word_generator_cubit.dart';

class WordGeneratorPage extends StatelessWidget {
  const WordGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
          customShowDialog(
              context: context,
              title: "Insufficient Words",
              content: "Couldn't generate all words with these modifiers.");
        }
        if (state is WordGeneratorGeneratedNoWords) {
          customShowDialog(
              context: context,
              title: "No Words",
              content: "Couldn't generate words with these modifiers.");
        }
      },
      builder: (context, state) {
        BuildContext mainContext = context;
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  startWithFocusNode.unfocus();
                  endWithFocusNode.unfocus();
                },
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: customBoxDecoration(
                          hasShadow: true,
                          shadowAlphaColor: 150,
                          shadowBlurRadius: 0.1,
                          shadowOffset: const Offset(3, 2),
                        ),
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            //1 Begin - End Of Word Fields
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: customTextFormField(
                                    controller: startWithController,
                                    focusNode: startWithFocusNode,
                                    label: "Start With",
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
                                Expanded(
                                  child: customTextFormField(
                                    controller: endWithController,
                                    focusNode: endWithFocusNode,
                                    label: "End With",
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

                            //1 Length - Count Of Word Fields
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: customSlider(
                                    borderColor:
                                        Colors.grey.shade500.withAlpha(190),
                                    title:
                                        "Word Length: ${cubit.wordLengthSlider.toInt()}",
                                    value: cubit.wordLengthSlider,
                                    onChanged: (newValue) {
                                      cubit.changeSlider(
                                        newValue: newValue.roundToDouble(),
                                        sliderCount: 0,
                                      );
                                    },
                                    verticalPadding: 10,
                                    horizontalPadding: 10,
                                    minValue: 0,
                                  ),
                                ),
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
                                        sliderCount: 1,
                                      );
                                    },
                                    verticalPadding: 10,
                                    horizontalPadding: 10,
                                    maxValue: 300,
                                  ),
                                  //          customTextFormField(
                                  //           controller: wordCountController,
                                  //           label: "Word Count",
                                  //           keyboardType:
                                  //               const TextInputType.numberWithOptions(
                                  //             signed: false,
                                  //             decimal: false,
                                  //           ),
                                  //           borderWidth: 0.5,
                                  //           borderColor: Colors.black.withAlpha(150),
                                  //           borderFocusedWidth: 0.5,
                                  //           focusBorderColor: Colors.black.withAlpha(150),
                                  //           hasShadow: true,
                                  //           shadowAlphaColor: 150,
                                  //           shadowBlurRadius: 0.1,
                                  //         ),
                                ),
                              ],
                            ),

                            //1 Word type Selection
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
                              ],
                              onChanged: (newValue) {
                                cubit.changeWordType(newValue: newValue ??= 0);
                              },
                            ),

                            //1 Confirmation Button
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
                              padding: 20,
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
                      //1 Results
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 250,
                          decoration: customBoxDecoration(
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
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Results:",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              cubit.words.isEmpty
                                  ? Expanded(
                                      child: Center(
                                        child: Text(
                                          "No results available...",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.words.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: customMaterialButton(
                                              // width: 100,
                                              // height: 50,
                                              fontSize: 30,
                                              text: cubit.words[index],

                                              //  WordGeneratorPlus().randomNounPlus(
                                              //     startsWith: "fa", endsWith: "rt",

                                              //     ),
                                              onPressed: () {},
                                              hasGradient: true,
                                              // gradientColors: [
                                              //   Colors.blue,
                                              //   Colors.blue,
                                              //   Colors.blue.shade400,
                                              //   Colors.blue.shade600,
                                              // ],
                                            ),
                                          );
                                        },
                                      ),
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
