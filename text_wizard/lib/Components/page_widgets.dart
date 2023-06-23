import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';

import '../Constants/colors.dart';
import 'custom_classes.dart';

Widget homeIcon({
  required BuildContext context,
  required String title,
  required Color color,
  required IconData icon,
  required Widget navigatePage,
  Color textColor = Colors.black,
  double size = 100,
  double horizontalPadding = 0,
  double verticalPadding = 0,
}) {
  Color? shadowColor = ColorTween(begin: color, end: Colors.black).lerp(0.3);
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, vertical: verticalPadding),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: customBoxDecoration(
              boxShape: BoxShape.circle,
              hasShadow: true,
              shadowOffset: const Offset(0, 10),
              shadowBlurRadius: 10,
              shadowColor: shadowColor ??= Colors.grey,
              shadowSpreadRadius: 0.3,
            ),
            child: Material(
              shape: const CircleBorder(),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  CustomNavigation navigate = CustomNavigation();
                 navigate.navigateTo(context: context, destination: navigatePage);
                },
                child: Ink(
                  decoration: customBoxDecoration(
                    boxShape: BoxShape.circle,
                    hasGradient: true,
                    gradientColors: [
                      color.withAlpha(150),
                      color,
                    ],
                  ),
                  child: ClipOval(
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: customText(
              text: title,
              fontSize: 15,
              isBold: true,
              textAlign: TextAlign.center,
              maxLines: 2,
              textColor: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customResultBox({
  String title = "",
  String result = "",
  Color borderColor = Colors.grey,
  double borderWidth = 0.6,
  double padding = 0,
}) {
  final textUtilities = TextUtilities();
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: customText(
            text: title,
            isBold: true,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: customBoxDecoration(
            hasBorder: true,
            hasGradient: true,
            hasShadow: true,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  textUtilities.copyToClipboard(
                    text: result,
                  );
                },
                icon: const Icon(
                  Icons.copy,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: customText(
                  text: result,
                  isBold: true,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget blurContainer({
  required Widget child,
  double borderRadius = 20,
  double xBlur = 20,
  double yBlur = 20,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: xBlur, sigmaY: yBlur),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    ),
  );
}

Widget customHomepageList({
  String title = "Text",
  double height = 200,
  double verticalMargin = 10,
  double horizontalMargin = 0,
  double borderRadius = 20,
  required List<HomepageElement> pages,

    // 1 Box Settings
  BoxShape boxShape = BoxShape.rectangle,
  Color boxColor = Colors.white,
  double? boxBorderRadius,
  double boxTopLeftBorderRadius = 10,
  double boxTopRightBorderRadius = 10,
  double boxBottomLeftBorderRadius = 10,
  double boxBottomRightBorderRadius = 10,

  // 2 Gradient Settings
  bool hasGradient = false,
  List<Color> gradientColors = const [],
  AlignmentGeometry gradientBegin = Alignment.topLeft,
  AlignmentGeometry gradientEnd = Alignment.bottomRight,

  // 3 Border Settings
  bool hasBorder = false,
  Color borderColor = greyBorderColor,
  double borderWidth = 0.6,

  // 4 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 0),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 20,
  double shadowSpreadRadius = 2,
}) {
  return Container(
    height: height,
    margin: EdgeInsets.symmetric(
        vertical: verticalMargin, horizontal: horizontalMargin),
    decoration: customBoxDecoration(
      hasBorder: true,
      borderWidth: 0.5,
      borderColor: greyBorderColor,
      hasShadow: true,
      shadowAlphaColor: 150,
      shadowBlurRadius: 0.4,
      shadowOffset: const Offset(0, 3),
      boxBorderRadius: borderRadius,
      hasGradient: false,
      gradientColors: [
        Colors.grey.shade400,
        Colors.grey.shade200,
      ],
      gradientBegin: Alignment.centerLeft,
      gradientEnd: Alignment.centerRight,
    ),
    child: blurContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Center(
              child: customText(
                text: title,
                isBold: true,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                itemCount: pages.length,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return homeIcon(
                    context: context,
                    title: pages[index].pageName,
                    color: pages[index].pageColor,
                    icon: pages[index].pageIcon,
                    navigatePage: pages[index].pageWidget,
                    size: 100,
                    horizontalPadding: 10,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
