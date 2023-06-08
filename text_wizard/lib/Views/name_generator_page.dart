import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tex_wiz/Components/functions.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';

import '../Constants/colors.dart';
import '../Cubit/NameGenerator/name_generator_cubit.dart';
import '../Cubit/NameGenerator/name_generator_state.dart';

class NameGeneratorPage extends StatelessWidget {
  const NameGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController startWithController = TextEditingController();
    TextEditingController endWithController = TextEditingController();
    FocusNode startWithFocusNode = FocusNode();
    FocusNode endWithFocusNode = FocusNode();

    return BlocConsumer<NameGeneratorCubit, NameGeneratorState>(
      listener: (context, state) {
        if (state is NameGeneratorGeneratingWords) {
          customLoadingDialog(context: context);
        }
        if (state is NameGeneratorFinishedGeneratingWords) {
          Navigator.pop(context);
        }
        if (state is NameGeneratorGeneratedFewWords) {
          Fluttertoast.showToast(
            msg: "Couldn't generate all words.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        }
        if (state is NameGeneratorGeneratedNoWords) {
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
        final cubit = NameGeneratorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              // 1 AppBar
              customAppbar(context: context, title: "Name Generator"),

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
                                              text: cubit.names.join("\n"),
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
                                              text: cubit.names.join("\n"),
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
                                    visible: cubit.names.isNotEmpty,
                                    child: Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.names.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: customMaterialButton(
                                              text: cubit.names[index],
                                              fontSize: 20,
                                              onPressed: () {
                                                copyToClipboard(
                                                  text: cubit.names[index],
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
                                              "Word Length: ${cubit.nameLengthSlider.toInt()==0?"Any":cubit.nameLengthSlider.toInt()}",
                                          value: cubit.nameLengthSlider,
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
                                              "Word Count: ${cubit.nameCountSlider.toInt()}",
                                          value: cubit.nameCountSlider,
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
