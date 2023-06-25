import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Components/custom_classes.dart';
import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';
import '../Cubit/WordTranslator/word_translator_cubit.dart';
import '../Cubit/WordTranslator/word_translator_state.dart';

class WordTranslatorPage extends StatelessWidget {
  const WordTranslatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputTextController = TextEditingController();
    TextEditingController outputTextController = TextEditingController();
    FocusNode startWithFocusNode = FocusNode();
    FocusNode endWithFocusNode = FocusNode();
    const Duration debounceDelay = Duration(milliseconds: 300);
    Timer? debounceTimer;
    final cubit = WordTranslatorCubit.getCubit(context);
    final textUtilities = TextUtilities();
    return BlocConsumer<WordTranslatorCubit, WordTranslatorState>(
      listener: (context, state) {
        if (state is WordTranslatorOptionChange) {
          if (debounceTimer?.isActive ?? false) {
            debounceTimer!.cancel();
          }
          debounceTimer = Timer(debounceDelay, () async {
            if (inputTextController.text.isNotEmpty) {
              outputTextController.text = await cubit.translateText();
            }
          });
        }
      },
      builder: (context, state) {
        inputTextController.addListener(() {
          if (debounceTimer?.isActive ?? false) {
            debounceTimer!.cancel();
          }
          debounceTimer = Timer(debounceDelay, () async {
            cubit.changeInputText(newValue: inputTextController.text);
            if (inputTextController.text.isNotEmpty) {
              outputTextController.text = await cubit.translateText();
            }
          });
        });
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              // 1 AppBar
              customAppbar(context: context, title: "Language Translation"),

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
                                          text: "Translation:",
                                          isBold: true,
                                          fontSize: 25,
                                        ),
                                      ),
                                      // 3 Copy To Clipboard Button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            textUtilities.copyToClipboard(
                                              text: outputTextController.text,
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
                                            textUtilities.shareText(
                                              text: outputTextController.text,
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: customTextFormField(
                                      isEnabled: false,
                                      controller: outputTextController,
                                      alwaysShowHint: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 1 Input Text Container
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
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        // 1 Input Language Field
                                        customTextDropDownMenu(
                                          selectedValue: cubit.inputLanguage,
                                          borderColor:
                                              Colors.black.withAlpha(150),
                                          borderWidth: 0.3,
                                          boxTopLeftBorderRadius: 15,
                                          boxBottomRightBorderRadius: 15,
                                          hasShadow: true,
                                          shadowAlphaColor: 150,
                                          shadowBlurRadius: 0.1,
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Auto Detect',
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child: customText(
                                                  text: "Auto Detect",
                                                ),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "English",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child:
                                                    customText(text: "English"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Arabic",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child:
                                                    customText(text: "Arabic"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Spanish",
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: customText(
                                                      text: "Spanish")),
                                            ),
                                          ],
                                          onChanged: (newValue) {
                                            cubit.changeLanguage(
                                              isInput: true,
                                              newValue: newValue,
                                            );
                                          },
                                        ),

                                        // 1 Swap Languages Button
                                        IconButton(
                                          icon: Icon(cubit.inputLanguage ==
                                                  "Auto Detect"
                                              ? Icons.arrow_forward
                                              : Icons.compare_arrows),
                                          onPressed: () async {
                                            if (cubit.inputLanguage !=
                                                "Auto Detect") {
                                              cubit.swapLanguages();
                                              outputTextController.text =
                                                  await cubit.translateText();
                                            }
                                          },
                                        ),

                                        // 1 Output language Field
                                        customTextDropDownMenu(
                                          selectedValue: cubit.outputLanguage,
                                          borderColor:
                                              Colors.black.withAlpha(150),
                                          borderWidth: 0.3,
                                          boxTopLeftBorderRadius: 15,
                                          boxBottomRightBorderRadius: 15,
                                          hasShadow: true,
                                          shadowAlphaColor: 150,
                                          shadowBlurRadius: 0.1,
                                          items: [
                                            DropdownMenuItem(
                                              value: "English",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child:
                                                    customText(text: "English"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Arabic",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child:
                                                    customText(text: "Arabic"),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Spanish",
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: customText(
                                                      text: "Spanish")),
                                            ),
                                          ],
                                          onChanged: (newValue) {
                                            cubit.changeLanguage(
                                              isInput: false,
                                              newValue: newValue,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 1 Input Text Field
                                  SizedBox(
                                    width: double.infinity,
                                    child: customTextFormField(
                                      controller: inputTextController,
                                      hint: "Enter Text",
                                      alwaysShowHint: true,
                                      maxLines: null,
                                    ),
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
