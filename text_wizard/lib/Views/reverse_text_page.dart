import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Views/options_page.dart';

import '../Components/custom_classes.dart';
import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';
import '../Cubit/ReverseText/reverse_text_cubit.dart';
import '../Cubit/ReverseText/reverse_text_state.dart';

class ReverseTextPage extends StatelessWidget {
  const ReverseTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController splitTextController = TextEditingController();
    TextEditingController replaceWithController = TextEditingController();
    TextEditingController prefixTextController = TextEditingController();
    TextEditingController suffixTextController = TextEditingController();
    TextEditingController inputTextController = TextEditingController();
    TextEditingController outputTextController = TextEditingController();

    return BlocConsumer<ReverseTextCubit, ReverseTextState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = ReverseTextCubit.getCubit(context);
        final textUtilities = TextUtilities();
        inputTextController.addListener(() {});
        return Scaffold(
          backgroundColor: backgroundColor,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                // 1 AppBar
                customAppbar(context: context, title: "Reverse Text"),

                // 1 Body
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            // 2 Input Text Container
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
                                  Row(
                                    children: [
                                      // 3 Container Label Text
                                      Expanded(
                                        child: customText(
                                          text: "Input:",
                                          isBold: true,
                                          fontSize: 25,
                                        ),
                                      ),
                                      // 3 Settings Button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            CustomNavigation navigate =
                                                CustomNavigation();
                                            navigate.navigateTo(
                                              context: context,
                                              destination: OptionsPage(
                                                pageOptions:
                                                    // 1 Text Options Container
                                                    Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 15,
                                                  ),
                                                  decoration:
                                                      customBoxDecoration(
                                                    boxTopLeftBorderRadius: 25,
                                                    boxBottomRightBorderRadius:
                                                        25,
                                                    hasBorder: true,
                                                    borderWidth: 0.5,
                                                    borderColor:
                                                        greyBorderColor,
                                                    hasShadow: true,
                                                    shadowAlphaColor: 150,
                                                    shadowBlurRadius: 0.1,
                                                    shadowOffset:
                                                        const Offset(3, 2),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 15,
                                                    horizontal: 10,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          customTextFormField(
                                                            label:
                                                                "Split Text at",
                                                            hint:
                                                                "Default: Space",
                                                            controller:
                                                                splitTextController,
                                                            verticalPadding: 10,
                                                            boxTopLeftBorderRadius:
                                                                15,
                                                            boxBottomRightBorderRadius:
                                                                15,
                                                            borderWidth: 0.5,
                                                            borderColor: Colors
                                                                .black
                                                                .withAlpha(150),
                                                            borderFocusedWidth:
                                                                0.5,
                                                            focusBorderColor:
                                                                Colors
                                                                    .black
                                                                    .withAlpha(
                                                                        150),
                                                            hasShadow: true,
                                                            shadowAlphaColor:
                                                                150,
                                                            shadowBlurRadius:
                                                                0.1,
                                                          ),
                                                          customTextFormField(
                                                            label:
                                                                "Replace With",
                                                            hint: "\\n",
                                                            controller:
                                                                replaceWithController,
                                                            verticalPadding: 10,
                                                            maxLines: null,
                                                            boxTopLeftBorderRadius:
                                                                15,
                                                            boxBottomRightBorderRadius:
                                                                15,
                                                            borderWidth: 0.5,
                                                            borderColor: Colors
                                                                .black
                                                                .withAlpha(150),
                                                            borderFocusedWidth:
                                                                0.5,
                                                            focusBorderColor:
                                                                Colors
                                                                    .black
                                                                    .withAlpha(
                                                                        150),
                                                            hasShadow: true,
                                                            shadowAlphaColor:
                                                                150,
                                                            shadowBlurRadius:
                                                                0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          customTextFormField(
                                                            label: "Prefix",
                                                            hint:
                                                                "example: Start",
                                                            controller:
                                                                prefixTextController,
                                                            verticalPadding: 10,
                                                            boxTopLeftBorderRadius:
                                                                15,
                                                            boxBottomRightBorderRadius:
                                                                15,
                                                            borderWidth: 0.5,
                                                            borderColor: Colors
                                                                .black
                                                                .withAlpha(150),
                                                            borderFocusedWidth:
                                                                0.5,
                                                            focusBorderColor:
                                                                Colors
                                                                    .black
                                                                    .withAlpha(
                                                                        150),
                                                            hasShadow: true,
                                                            shadowAlphaColor:
                                                                150,
                                                            shadowBlurRadius:
                                                                0.1,
                                                          ),
                                                          customTextFormField(
                                                            label:
                                                                "Suffix Text",
                                                            hint:
                                                                "example: End",
                                                            controller:
                                                                suffixTextController,
                                                            verticalPadding: 10,
                                                            boxTopLeftBorderRadius:
                                                                15,
                                                            boxBottomRightBorderRadius:
                                                                15,
                                                            borderWidth: 0.5,
                                                            borderColor: Colors
                                                                .black
                                                                .withAlpha(150),
                                                            borderFocusedWidth:
                                                                0.5,
                                                            focusBorderColor:
                                                                Colors
                                                                    .black
                                                                    .withAlpha(
                                                                        150),
                                                            hasShadow: true,
                                                            shadowAlphaColor:
                                                                150,
                                                            shadowBlurRadius:
                                                                0.1,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.settings,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
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

                            // 3 Output Text Container
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
                                          text: "Output:",
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
                          ],
                        ),
                      ),
                    ],
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
