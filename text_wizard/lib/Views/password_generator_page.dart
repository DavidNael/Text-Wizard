import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';
import 'package:tex_wiz/Constants/colors.dart';
import 'package:tex_wiz/Cubit/PasswordGenerator/password_generator_cubit.dart';

import '../Cubit/PasswordGenerator/password_generator_state.dart';

class PasswordGeneratorPage extends StatelessWidget {
  const PasswordGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    return BlocConsumer<PasswordGeneratorCubit, PasswordGeneratorState>(
      listener: (context, state) {},
      builder: (context, state) {
        // BuildContext mainContext = context;
        final cubit = PasswordGeneratorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            slivers: [
              // 1 AppBar
              customAppbar(context: context, title: "Password Generator"),

              // 1 Body
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            //1  Result Box
                            customResultBox(
                              title: "Generated Password: ",
                              result: cubit.password,
                            ),

                            //1 Password Length
                            customSlider(
                              title:
                                  "Password Length: ${cubit.passwordLengthValue.toInt()}",
                              value: cubit.passwordLengthValue,
                              onChanged: (newValue) {
                                cubit.changeSlider(
                                    newValue: newValue.roundToDouble());
                              },
                              verticalPadding: 20,
                              minValue: 8,
                            ),

                            // 1 Include Numbers
                            customCheckbox(
                              text: "Include Numbers",
                              isActive: cubit.options[0],
                              onTap: () {
                                cubit.changeOptionType(optionNumber: 0);
                              },
                            ),

                            // 1 Include Capital Letters
                            customCheckbox(
                              text: "Include Capital Characters",
                              isActive: cubit.options[1],
                              onTap: () {
                                cubit.changeOptionType(optionNumber: 1);
                              },
                            ),

                            // 1 Include Special Letters
                            customCheckbox(
                              text: "Include Special Characters",
                              isActive: cubit.options[2],
                              onTap: () {
                                cubit.changeOptionType(optionNumber: 2);
                              },
                            ),

                            //1 Confirmation Button
                            customMaterialButton(
                              text: "Generate",
                              onPressed: () {
                                cubit.generatePassword();
                              },
                              hasGradient: true,
                              gradientColors: buttonGradientColors,
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
