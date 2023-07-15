import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Views/options_page.dart';

import '../Components/custom_classes.dart';
import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';
import '../Cubit/SpaceIncreaser/space_increaser_cubit.dart';
import '../Cubit/SpaceIncreaser/space_increaser_state.dart';

class SpaceIncreaserPage extends StatelessWidget {
  const SpaceIncreaserPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputTextController = TextEditingController();
    TextEditingController outputTextController = TextEditingController();

    final cubit = SpaceIncreaserCubit.getCubit(context);
    return BlocConsumer<SpaceIncreaserCubit, SpaceIncreaserState>(
      listener: (context, state) {
        if (state is SpaceIncreaserOptionChange) {
          outputTextController.text = cubit.increaseSpaces(
            text: inputTextController.text,
          );
        }
      },
      builder: (context, state) {
        inputTextController.addListener(() {
          outputTextController.text = cubit.increaseSpaces(
            text: inputTextController.text,
          );
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
                customAppbar(context: context, title: "Space Increaser"),

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
                                                  SpaceIncreaserCubit,
                                                  SpaceIncreaserState>(
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
                                                          customSlider(
                                                            hasBorder: true,
                                                            borderColor: Colors
                                                                .grey.shade500
                                                                .withAlpha(190),
                                                            title:
                                                                "Spaces To Increase: ${cubit.spaceSliderValue.toInt()}",
                                                            value: cubit
                                                                .spaceSliderValue,
                                                            onChanged:
                                                                (newValue) {
                                                              cubit.changeSpaceSliderValue(
                                                                  value:
                                                                      newValue);
                                                            },
                                                            minValue: 0,
                                                          ),
                                                          customCheckbox(
                                                            text:
                                                                "Ignore Spaces",
                                                            isActive: cubit
                                                                .ignoreSpaces,
                                                            onTap: () {
                                                              cubit
                                                                  .changeIgnoreSpace();
                                                            },
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
                                            TextUtilities.copyToClipboard(
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
                                            TextUtilities.shareText(
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
