import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Components/ui_widgets.dart';
import 'package:text_wizard/Cubit/PasswordGenerator/password_generator_cubit.dart';

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
            title: const Text("𝗣𝗮𝘀𝘀𝘄𝗼𝗿𝗱 𝗚𝗲𝗻𝗲𝗿𝗮𝘁𝗼𝗿"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Form(
                child: Column(
                  children: [
                    //1  Result Box
                    customResultBox(
                      title: "Generated Password: ",
                      result: "nbgjlwns*Gw48fqf@r98hg21564##15#qr123r4661",
                    ),
                    // 1 Password Length
                    customSlider(
                      title: "Password Length: ${cubit.sliderValue.toInt()}",
                      value: cubit.sliderValue,
                      onChanged: (newValue) {
                        cubit.changeSlider(newValue: newValue.roundToDouble());
                      },
                      verticalPadding: 20,
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
                      onPressed: () {},
                      // padding: 20,
                      hasGradient: true,
                      gradientColors: [
                        Colors.blue,
                        Colors.blue,
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                      ],
                    ),

                    // 1 Results
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       width: 0.5,
                    //       color: Colors.grey.withAlpha(100),
                    //     ),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: 50,
                    //     itemBuilder: (context, index) {
                    //       return Text("Placeholder $index");
                    //       // customMaterialButton(
                    //       //   text: "PlaceHolder $index",
                    //       //   onPressed: () {},
                    //       // );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
