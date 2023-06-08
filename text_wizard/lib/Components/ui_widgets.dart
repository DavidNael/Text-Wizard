import 'package:tex_wiz/Constants/fonts.dart';

import 'custom_classes.dart';
import 'functions.dart';
import 'transition_widgets.dart';
import 'package:flutter/material.dart';

BoxShadow customBoxShadow({
  Color shadowColor = Colors.grey,
  Offset offset = const Offset(0, 0),
  double blurRadius = 20,
  double spreadRadius = 2,
  int alphaColor = 255,
}) {
  return BoxShadow(
    offset: offset,
    blurRadius: blurRadius,
    color: shadowColor.withAlpha(alphaColor),
    spreadRadius: spreadRadius,
  );
}

Border customBorder({
  Color borderColor = Colors.grey,
  double borderWidth = 0.6,
}) {
  return Border.all(
    color: borderColor,
    width: borderWidth,
  );
}

LinearGradient customLinearGradient({
  List<Color> colors = const [],
  AlignmentGeometry begin = Alignment.topLeft,
  AlignmentGeometry end = Alignment.bottomRight,
}) {
  List<Color> defaultColors = [
    Colors.blue.withAlpha(150),
    Colors.indigo.shade400,
    Colors.indigo.shade600,
    Colors.indigo.shade800,
  ];
  return LinearGradient(
    colors: colors.isNotEmpty ? colors : defaultColors,
    begin: begin,
    end: end,
  );
}

BoxDecoration customBoxDecoration({
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
  Color borderColor = Colors.grey,
  double borderWidth = 0.6,

  // 4 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 0),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 20,
  double shadowSpreadRadius = 2,
}) {
  return BoxDecoration(
    shape: boxShape,
    color: boxColor,
    gradient: hasGradient
        ? customLinearGradient(
            colors: gradientColors,
            begin: gradientBegin,
            end: gradientEnd,
          )
        : null,
    border: hasBorder
        ? customBorder(
            borderColor: borderColor,
            borderWidth: borderWidth,
          )
        : null,
    borderRadius: boxShape == BoxShape.circle
        ? null
        : boxBorderRadius != null
            ? BorderRadius.circular(boxBorderRadius)
            : BorderRadius.only(
                topLeft: Radius.circular(boxTopLeftBorderRadius),
                topRight: Radius.circular(boxTopRightBorderRadius),
                bottomLeft: Radius.circular(boxBottomLeftBorderRadius),
                bottomRight: Radius.circular(boxBottomRightBorderRadius),
              ),
    boxShadow: hasShadow
        ? [
            customBoxShadow(
              alphaColor: shadowAlphaColor,
              blurRadius: shadowBlurRadius,
              offset: shadowOffset,
              shadowColor: shadowColor,
              spreadRadius: shadowSpreadRadius,
            ),
          ]
        : null,
  );
}

Text customText({
  String text = "Test",
  int? maxLines,
  double? letterSpacing,
  double? wordSpacing,
  double? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool isUnderlined = false,
  bool isLineThrough = false,
  bool isOverline = false,
  isEllipsis = false,
  fontFamily = AppFonts.openSans,
  Color textColor = Colors.black,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      fontFamily: fontFamily,
      color: textColor,
      decoration: isUnderlined
          ? TextDecoration.underline
          : isLineThrough
              ? TextDecoration.lineThrough
              : isOverline
                  ? TextDecoration.overline
                  : TextDecoration.none,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    ),
    maxLines: maxLines,
    overflow: isEllipsis ? TextOverflow.ellipsis : TextOverflow.visible,
    textAlign: textAlign,
  );
}

Widget homeIcon({
  required BuildContext context,
  required String title,
  required Color color,
  required IconData icon,
  required Widget navigatePage,
  double size = 100,
}) {
  Color? shadowColor = ColorTween(begin: color, end: Colors.black).lerp(0.3);
  return FittedBox(
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
                navigateTo(context: context, destination: navigatePage);
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
          ),
        ),
      ],
    ),
  );
}

Widget customIconWidget({
  Color color = Colors.indigo,
  double size = 20,
  IconData icon = Icons.info,
  VoidCallback? onPressed,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
      size: 35,
      color: Colors.white,
    ),
  );
}

Widget customTextDropDownMenu({
  int selectedValue = 0,
  double width = 180,
  double? height,
  double padding = 10,
  List<DropdownMenuItem<int>>? items,
  void Function(int?)? onChanged,
  // 1 Box Settings
  BoxShape boxShape = BoxShape.rectangle,
  Color boxColor = Colors.white,
  double? boxBorderRadius,
  double boxTopLeftBorderRadius = 5,
  double boxTopRightBorderRadius = 10,
  double boxBottomLeftBorderRadius = 10,
  double boxBottomRightBorderRadius = 10,

  // 2 Gradient Settings
  bool hasGradient = false,
  List<Color> gradientColors = const [],
  AlignmentGeometry gradientBegin = Alignment.topLeft,
  AlignmentGeometry gradientEnd = Alignment.bottomRight,

  // 3 Border Settings
  bool hasBorder = true,
  double borderRadius = 20,
  double borderWidth = 0,
  Color borderColor = Colors.transparent,

  // 4 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 2),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 10,
  double shadowSpreadRadius = 0.3,
}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Container(
      width: width,
      height: height,
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: customBoxDecoration(
        boxColor: boxColor,
        boxShape: boxShape,
        boxBorderRadius: boxBorderRadius,
        boxTopLeftBorderRadius: boxTopLeftBorderRadius,
        boxTopRightBorderRadius: boxTopRightBorderRadius,
        boxBottomLeftBorderRadius: boxBottomLeftBorderRadius,
        boxBottomRightBorderRadius: boxBottomRightBorderRadius,
        hasBorder: true,
        borderColor: borderColor,
        borderWidth: borderWidth,
        hasGradient: hasGradient,
        gradientBegin: gradientBegin,
        gradientColors: gradientColors,
        gradientEnd: gradientEnd,
        hasShadow: hasShadow,
        shadowAlphaColor: shadowAlphaColor,
        shadowBlurRadius: shadowBlurRadius,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        shadowSpreadRadius: shadowBlurRadius,
      ),
      alignment: Alignment.topRight,
      child: Align(
        alignment: Alignment.center,
        child: DropdownButton<int>(
          underline: Container(),
          isExpanded: true,
          value: selectedValue,
          borderRadius: BorderRadius.circular(borderRadius),
          onChanged: onChanged,
          items: items,
        ),
      ),
    ),
  );
}

Widget customTextFormField({
  VoidCallback? onPressed,
  String label = "",
  String? hint,
  Color? titleColor,
  Color backgroundColor = Colors.white,
  Color? focusBackgroundColor,
  Color focusBorderColor = Colors.transparent,
  double width = 180,
  double? height,
  double borderFocusedRadius = 10,
  double borderFocusedWidth = 0,
  double verticalPadding = 0,
  double horizontalPadding = 0,
  double? fontSize,
  double? hintFontSize,
  TextEditingController? controller,
  FocusNode? focusNode,
  TextInputType keyboardType = TextInputType.text,

  // 1 Border Settings
  bool hasBorder = true,
  double? boxBorderRadius,
  double borderWidth = 0,
  double boxTopLeftBorderRadius = 10,
  double boxTopRightBorderRadius = 10,
  double boxBottomLeftBorderRadius = 10,
  double boxBottomRightBorderRadius = 10,
  Color borderColor = Colors.transparent,

  // 2 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 2),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 10,
  double shadowSpreadRadius = 0.3,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: verticalPadding, horizontal: horizontalPadding),
    child: Container(
      width: width,
      height: height,
      decoration: customBoxDecoration(
        boxTopLeftBorderRadius: boxTopLeftBorderRadius,
        boxTopRightBorderRadius: boxTopRightBorderRadius,
        boxBottomLeftBorderRadius: boxBottomLeftBorderRadius,
        boxBottomRightBorderRadius: boxBottomRightBorderRadius,
        hasShadow: hasShadow,
        shadowAlphaColor: shadowAlphaColor,
        shadowBlurRadius: shadowBlurRadius,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        shadowSpreadRadius: shadowSpreadRadius,
      ),
      // padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          label: customText(
            text: label,
            fontSize: fontSize,
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(boxTopLeftBorderRadius),
              topRight: Radius.circular(boxTopRightBorderRadius),
              bottomLeft: Radius.circular(boxBottomLeftBorderRadius),
              bottomRight: Radius.circular(boxBottomRightBorderRadius),
            ),
            borderSide: BorderSide(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(boxTopLeftBorderRadius),
              topRight: Radius.circular(boxTopRightBorderRadius),
              bottomLeft: Radius.circular(boxBottomLeftBorderRadius),
              bottomRight: Radius.circular(boxBottomRightBorderRadius),
            ),
            borderSide: BorderSide(
              width: borderFocusedWidth,
              color: focusBorderColor,
            ),
          ),
        ),
      ),
    ),
  );
}

void customModalButton({
  required BuildContext context,
  required Widget builder,
  bool isScrollable = false,
}) {
  showModalBottomSheet(
    isScrollControlled: isScrollable,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return builder;
    },
  );
}

Widget customExpansionTile({
  required String title,
  List<Widget> children = const <Widget>[],
  double collapsedBorderRadius = 10,
  double borderRadius = 10,
  double padding = 10,
  Color? collapsedBackgroundColor,
  Color? backgroundColor,
  bool isExpanded = false,
}) {
  return ExpansionTile(
    initiallyExpanded: isExpanded,
    title: customText(
      text: title,
    ),
    childrenPadding: EdgeInsets.all(padding),
    collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(collapsedBorderRadius)),
    collapsedBackgroundColor: collapsedBackgroundColor,
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius)),
    children: children,
  );
}

Widget customElevatedButton({
  required String text,
  double width = 100,
  double height = 50,
  Color buttonColor = Colors.blue,
  Color textColor = Colors.white,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: buttonColor,
      ),
      child: customText(
        text: text,
        textColor: textColor,
      ),
    ),
  );
}

Widget customMaterialButton({
  String text = "",
  double? width,
  double? height = 60,
  double horizontalPadding = 0,
  double verticalPadding = 0,
  double fontSize = 15,
  Color buttonColor = Colors.blue,
  Color textColor = Colors.white,
  int? maxLines = 1,

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
  VoidCallback? onPressed,

  // 3 Border Settings
  bool hasBorder = true,
  double borderWidth = 0,
  Color borderColor = Colors.transparent,

  // 3 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 2),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 10,
  double shadowSpreadRadius = 0.3,
}) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.symmetric(
      vertical: verticalPadding,
      horizontal: horizontalPadding,
    ),
    decoration: customBoxDecoration(
      boxShape: boxShape,
      boxColor: boxColor,
      boxBorderRadius: boxBorderRadius,
      boxTopLeftBorderRadius: boxTopLeftBorderRadius,
      boxTopRightBorderRadius: boxTopRightBorderRadius,
      boxBottomLeftBorderRadius: boxBottomLeftBorderRadius,
      boxBottomRightBorderRadius: boxBottomRightBorderRadius,
      hasGradient: hasGradient,
      gradientBegin: gradientBegin,
      gradientEnd: gradientEnd,
      gradientColors: gradientColors,
      hasBorder: hasBorder,
      borderWidth: borderWidth,
      borderColor: borderColor,
      hasShadow: hasShadow,
      shadowColor: shadowColor,
      shadowOffset: shadowOffset,
      shadowAlphaColor: shadowAlphaColor,
      shadowBlurRadius: shadowBlurRadius,
      shadowSpreadRadius: shadowSpreadRadius,
    ),
    child: Material(
      color: hasGradient ? Colors.transparent : buttonColor,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(boxTopLeftBorderRadius),
          topRight: Radius.circular(boxTopRightBorderRadius),
          bottomLeft: Radius.circular(boxBottomLeftBorderRadius),
          bottomRight: Radius.circular(boxBottomRightBorderRadius),
        ),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: customText(
              text: text,
              textColor: textColor,
              fontSize: fontSize,
              maxLines: maxLines,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget customCheckbox({
  bool isActive = false,
  String text = "",
  double checkboxSize = 24.0,
  double borderRadius = 5.0,
  VoidCallback? onTap,
  Color activeCheckboxColor = Colors.blue,
}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap ??= () {},
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: checkboxSize,
            height: checkboxSize,
            decoration: customBoxDecoration(
              boxTopLeftBorderRadius: borderRadius,
              hasBorder: true,
              borderColor: isActive ? activeCheckboxColor : Colors.grey,
              borderWidth: 2,
            ),
            // alignment: Alignment.center,
            child: isActive
                ? Icon(
                    Icons.check,
                    color: activeCheckboxColor,
                    size: checkboxSize * 0.8,
                  )
                : null,
          ),
        ),
      ),
      customText(
        text: text,
      ),
    ],
  );
}

Widget customSlider({
  String title = "",
  double value = 0,
  double checkboxSize = 24.0,
  double borderRadius = 4.0,
  double minValue = 1,
  double maxValue = 50,
  double verticalPadding = 0,
  double horizontalPadding = 0,
  void Function(double)? onChanged,
  Color activeCheckboxColor = Colors.blue,
  // 2 Border Settings
  bool hasBorder = true,
  double? boxBorderRadius,
  double borderWidth = 0.9,
  double boxTopLeftBorderRadius = 10,
  double boxTopRightBorderRadius = 10,
  double boxBottomLeftBorderRadius = 10,
  double boxBottomRightBorderRadius = 10,
  Color borderColor = Colors.grey,

  // 3 Shadow Settings
  bool hasShadow = false,
  Color shadowColor = Colors.grey,
  Offset shadowOffset = const Offset(0, 2),
  int shadowAlphaColor = 255,
  double shadowBlurRadius = 10,
  double shadowSpreadRadius = 0.3,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: verticalPadding,
      horizontal: horizontalPadding,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: customText(
            text: title,
            isBold: true,
          ),
        ),
        Container(
          decoration: customBoxDecoration(
            boxTopLeftBorderRadius: boxTopLeftBorderRadius,
            boxTopRightBorderRadius: boxTopRightBorderRadius,
            boxBottomLeftBorderRadius: boxBottomLeftBorderRadius,
            boxBottomRightBorderRadius: boxBottomRightBorderRadius,
            hasBorder: hasBorder,
            borderWidth: borderWidth,
            borderColor: borderColor,
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
            min: minValue,
            max: maxValue,
          ),
        ),
      ],
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
                  copyToClipboard(
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

SliverAppBar customAppbar({
  required BuildContext context,
  required String title,
}) {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 170,
    flexibleSpace: Stack(
      children: [
        ClipPath(
          clipper: WavyAppBarClipper(),
          child: Container(
            decoration: customBoxDecoration(
              hasGradient: true,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    ),
    centerTitle: true,
    floating: true,
    automaticallyImplyLeading: false,
  );
}
