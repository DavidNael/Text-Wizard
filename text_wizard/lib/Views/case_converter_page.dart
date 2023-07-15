import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Views/options_page.dart';

import '../Components/custom_classes.dart';
import '../Components/ui_widgets.dart';
import '../Constants/colors.dart';
import '../Cubit/CaseConverter/case_converter_cubit.dart';
import '../Cubit/CaseConverter/case_converter_state.dart';

class CaseConverterPage extends StatelessWidget {
  const CaseConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputTextController = TextEditingController();
    TextEditingController outputTextController = TextEditingController();
    final cubit = CaseConverterCubit.getCubit(context);

    return BlocConsumer<CaseConverterCubit, CaseConverterState>(
      listener: (context, state) {
        if (state is CaseConverterOptionChange) {
          outputTextController.text =
              cubit.convertCase(text: inputTextController.text);
        }
      },
      builder: (context, state) {
        inputTextController.addListener(() {
          outputTextController.text =
              cubit.convertCase(text: inputTextController.text);
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
                customAppbar(context: context, title: "Case Converter"),

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
                                              destination: const OptionsPage(
                                                pageOptions: Placeholder(),
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
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        // 1 Input Language Field
                                        customTextDropDownMenu(
                                          selectedValue: cubit.inputCase,
                                          borderColor:
                                              Colors.black.withAlpha(150),
                                          borderWidth: 0.3,
                                          boxTopLeftBorderRadius: 15,
                                          boxBottomRightBorderRadius: 15,
                                          hasShadow: true,
                                          shadowAlphaColor: 150,
                                          shadowBlurRadius: 0.1,
                                          items: cubit.dropdownItems,
                                          onChanged: (newValue) {
                                            cubit.updateCase(
                                              newInputCase: newValue,
                                            );
                                          },
                                        ),

                                        // 1 Swap Languages Button
                                        IconButton(
                                          icon: const Icon(Icons.arrow_forward),
                                          onPressed: () async {},
                                        ),

                                        // 1 Output language Field
                                        customTextDropDownMenu(
                                            selectedValue: cubit.outputCase,
                                            borderColor:
                                                Colors.black.withAlpha(150),
                                            borderWidth: 0.3,
                                            boxTopLeftBorderRadius: 15,
                                            boxBottomRightBorderRadius: 15,
                                            hasShadow: true,
                                            shadowAlphaColor: 150,
                                            shadowBlurRadius: 0.1,
                                            items: cubit.dropdownItems,
                                            onChanged: (newValue) {
                                              cubit.updateCase(
                                                newOutputCase: newValue,
                                              );
                                            }),
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
