import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_cubit.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_state.dart';

import '../Components/page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    return BlocConsumer<HomepageCubit, HomepageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomepageCubit.getCubit(mainContext);
        return Scaffold(
          backgroundColor: Colors.grey[200],
          drawer: Drawer(
            backgroundColor: Colors.black.withAlpha(50),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // 1 Header Bar
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: customBoxDecoration(
                    boxBottomLeftBorderRadius: 20,
                    boxBottomRightBorderRadius: 20,
                    hasShadow: false,
                    shadowBlurRadius: 20,
                    shadowSpreadRadius: 20,
                    shadowColor: Colors.grey,
                    hasGradient: true,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          //1 Menu Icon
                          Align(
                            alignment: Alignment.topLeft,
                            child: Builder(
                              builder: (context) {
                                return customIconWidget(
                                  color: Colors.white,
                                  icon: Icons.menu,
                                  size: 35,
                                  onPressed: () {
                                    cubit.openDrawer(context: context);
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //1 Avatar
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 90,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                //1 Username
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back..",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "David Nael",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 1 Page Options

                // 1 Text Generation
                customHomepageList(
                  title: "Text Generation",
                  pages: cubit.textGenerationPages,
                  hasShadow: false,
                ),

                // 1 Text Manipulation
                customHomepageList(
                  title: "Text Manipulation",
                  pages: cubit.textManipulationPages,
                  hasShadow: false,
                ),

                // 1 Text Analysis
                customHomepageList(
                  title: "Text Analysis",
                  pages: cubit.textAnalysisPages,
                  hasShadow: false,
                ),

                // 1 Encoder-Decoder
                customHomepageList(
                  title: "Encoder-Decoder",
                  pages: cubit.encodingDecodingPages,
                  hasShadow: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
