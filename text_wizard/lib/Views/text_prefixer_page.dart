import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Views/options_page.dart';

import '../Components/custom_classes.dart';
import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';
import '../Cubit/TextPrefixer/text_prefixer_cubit.dart';
import '../Cubit/TextPrefixer/text_prefixer_state.dart';

class TextPrefixerPage extends StatelessWidget {
  const TextPrefixerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TextPrefixerCubit.getCubit(context);
    return BlocConsumer<TextPrefixerCubit, TextPrefixerState>(
      listener: (context, state) {
        if (state is TextPrefixerOptionChange) {
          cubit.outputTextController.text = cubit.textPrefixer();
        }
      },
      builder: (context, state) {
        cubit.inputTextController.addListener(() {
          cubit.outputTextController.text = cubit.textPrefixer();
        });
        cubit.prefixTextController.addListener(() {
          cubit.outputTextController.text = cubit.textPrefixer();
        });
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
                customAppbar(context: context, title: "Text Prefixer"),

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
                                              destination: BlocBuilder<
                                                  TextPrefixerCubit,
                                                  TextPrefixerState>(
                                                builder: (context, state) {
                                                  return OptionsPage(
                                                    pageOptions:
                                                        // 1 Text Options Container
                                                        Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 15,
                                                      ),
                                                      decoration:
                                                          customBoxDecoration(
                                                        boxTopLeftBorderRadius:
                                                            25,
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
                                                          customTextFormField(
                                                            label: "Prefix",
                                                            hint:
                                                                "example: Start",
                                                            controller: cubit
                                                                .prefixTextController,
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
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              customCheckbox(
                                                                text:
                                                                    "Ignore Spaces",
                                                                isActive: cubit
                                                                        .options[
                                                                    "ignoreSpaces"]!,
                                                                onTap: () {
                                                                  cubit
                                                                      .setOption(
                                                                    option: cubit
                                                                        .options
                                                                        .keys
                                                                        .elementAt(
                                                                            0),
                                                                  );
                                                                },
                                                              ),
                                                              customCheckbox(
                                                                  text:
                                                                      "Ignore New Lines",
                                                                  isActive: cubit
                                                                          .options[
                                                                      "ignoreNewLines"]!,
                                                                  onTap: () {
                                                                    cubit
                                                                        .setOption(
                                                                      option: cubit
                                                                          .options
                                                                          .keys
                                                                          .elementAt(
                                                                              1),
                                                                    );
                                                                  }),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                      controller: cubit.inputTextController,
                                      hint: "Enter Text",
                                      alwaysShowHint: true,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
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
                                            TextUtilities.copyToClipboard(
                                              text: cubit
                                                  .outputTextController.text,
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
                                            TextUtilities.shareText(
                                              text: cubit
                                                  .outputTextController.text,
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
                                      controller: cubit.outputTextController,
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
