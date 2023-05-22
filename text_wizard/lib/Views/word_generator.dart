import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_wizard/Widgets/ui_widgets.dart';
import 'package:text_wizard/Cubit/WordGenerator/word_generator_cubit.dart';

class WordGeneratorPage extends StatelessWidget {
  const WordGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<WordGeneratorCubit, WordGeneratorState>(
      listener: (context, state) {},
      builder: (context, state) {
        BuildContext mainContext = context;
        final cubit = WordGeneratorCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade800.withAlpha(0),
            shadowColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 200,
            flexibleSpace: ClipPath(
              clipper: WavyAppBarClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: customLinearGradient(),
                ),
              ),
            ),
            title: const Text("𝗪𝗼𝗿𝗱 𝗚𝗲𝗻𝗲𝗿𝗮𝘁𝗼𝗿"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    //1 Begin - End Of Word Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: customTextFormField(
                            label: "Start With",
                            borderWidth: 0.5,
                            borderColor: Colors.black.withAlpha(150),
                            borderFocusedWidth: 0.5,
                            focusBorderColor: Colors.black.withAlpha(150),
                          ),
                        ),
                        Expanded(
                          child: customTextFormField(
                            label: "End With",
                            borderWidth: 0.5,
                            borderColor: Colors.black.withAlpha(150),
                            borderFocusedWidth: 0.5,
                            focusBorderColor: Colors.black.withAlpha(150),
                          ),
                        ),
                      ],
                    ),

                    //1 Length - Count Of Word Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: customTextFormField(
                            label: "Word Length",
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            borderWidth: 0.5,
                            borderColor: Colors.black.withAlpha(150),
                            borderFocusedWidth: 0.5,
                            focusBorderColor: Colors.black.withAlpha(150),
                          ),
                        ),
                        Expanded(
                          child: customTextFormField(
                            label: "Word Count",
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            borderWidth: 0.5,
                            borderColor: Colors.black.withAlpha(150),
                            borderFocusedWidth: 0.5,
                            focusBorderColor: Colors.black.withAlpha(150),
                          ),
                        ),
                      ],
                    ),

                    //1 Word type Selection
                    customTextDropDownMenu(
                      borderColor: Colors.black.withAlpha(150),
                      borderWidth: 0.3,
                      borderRadius: 10,
                      selectedValue: cubit.wordTypeValue,
                      items: [
                        const DropdownMenuItem(
                          value: 0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('All Words')),
                        ),
                        const DropdownMenuItem(
                          value: 1,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('Verbs')),
                        ),
                        const DropdownMenuItem(
                          value: 2,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('Nouns')),
                        ),
                      ],
                      onChanged: (newValue) {
                        cubit.changeWordType(newValue: newValue ??= 0);
                      },
                    ),

                    //1 Confirmation Button
                    customMaterialButton(
                      text: "Generate",
                      onPressed: () {},
                      padding: 20,
                      buttonGradient: customLinearGradient(
                        color1: Colors.blue,
                        color2: Colors.blue,
                        color3: Colors.blue.shade400,
                        color4: Colors.blue.shade600,
                      ),
                    ),

                    //1 Results
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey.withAlpha(100),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Text("Placeholder $index");
                          // customMaterialButton(
                          //   text: "PlaceHolder $index",
                          //   onPressed: () {},
                          // );
                        },
                      ),
                    ),
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
