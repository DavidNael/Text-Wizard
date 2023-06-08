import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_cubit.dart';
import 'package:tex_wiz/Cubit/Homepage/homepage_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    return BlocConsumer<HomepageCubit, HomepageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomepageCubit.getCubit(mainContext);
        return Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.black.withAlpha(50),
          ),
          body: Column(
            children: [
              // 1 Header Bar
              Container(
                height: 300,
                width: double.infinity,
                decoration: customBoxDecoration(
                  boxBottomLeftBorderRadius: 20,
                  boxBottomRightBorderRadius: 20,
                  hasShadow: true,
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
              Expanded(
                child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                  ),

                  itemCount: cubit.pages.length,
                  itemBuilder: (context, index) {
                    return homeIcon(
                      context: context,
                      title: cubit.pages[index].pageName,
                      color: cubit.pages[index].pageColor,
                      icon: cubit.pages[index].pageIcon,
                      navigatePage: cubit.pages[index].pageWidget,
                      size: 100,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
