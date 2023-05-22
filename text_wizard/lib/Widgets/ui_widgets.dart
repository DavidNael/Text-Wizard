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

Widget homeIcon({
  required BuildContext context,
  required String title,
  required Color color,
  required IconData icon,
  required Widget navigatePage,
}) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 20,
              color: color.withAlpha(40),
              spreadRadius: 2,
            )
          ],
        ),
        child: Material(
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              navigateTo(context: context, destination: navigatePage);
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withAlpha(150),
                    color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
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
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
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

LinearGradient customLinearGradient(
    {Color? color1,
    Color? color2,
    Color? color3,
    Color? color4,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight}) {
  color1 ??= Colors.blue.withAlpha(150);
  color2 ??= Colors.indigo.shade400;
  color3 ??= Colors.indigo.shade600;
  color4 ??= Colors.indigo.shade800;

  return LinearGradient(
    colors: [
      color1,
      color2,
      color3,
      color4,
    ],
    begin: begin,
    end: end,
  );
}

Widget customTextDropDownMenu({
  int selectedValue = 0,
  double width = 180,
  double? height,
  double borderRadius = 20,
  double borderWidth = 0,
  Color borderColor = Colors.transparent,
  List<DropdownMenuItem<int>>? items,
  void Function(int?)? onChanged,
}) {
  return Container(
    width: width,
    height: height,
    // padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      border: Border.all(
        width: borderWidth,
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
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
  );
}

Widget customTextFormField({
  VoidCallback? onPressed,
  String label = "",
  Color? titleColor,
  Color backgroundColor = Colors.white,
  Color borderColor = Colors.transparent,
  Color? focusBackgroundColor,
  Color focusBorderColor = Colors.transparent,
  double width = 180,
  double? height,
  double borderRadius = 10,
  double borderWidth = 0,
  double borderFocusedRadius = 10,
  double borderFocusedWidth = 0,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white24,
        label: Text(label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderFocusedRadius),
          borderSide: BorderSide(
            width: borderFocusedWidth,
            color: focusBorderColor,
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
    title: Text(
      title,
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
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    ),
  );
}

Widget customMaterialButton({
  required String text,
  double width = 100,
  double height = 50,
  double padding = 10,
  Color buttonColor = Colors.blue,
  Color textColor = Colors.white,
  Gradient? buttonGradient,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: buttonGradient,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
        color: buttonGradient != null ? Colors.transparent : buttonColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

Widget CustomCheckbox({
  bool isActive = false,
  String text = "",
  double checkboxSize = 24.0,
  double borderRadius = 4.0,
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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isActive ? activeCheckboxColor : Colors.grey,
                width: 2.0,
              ),
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
      Text(text),
    ],
  );
}

Widget CustomSlider({
  String text = "",
  double value = 0,
  double checkboxSize = 24.0,
  double borderRadius = 4.0,
  double minValue = 1,
  double maxValue = 50,
  double padding = 0,
  void Function(double)? onChanged,
  Color activeCheckboxColor = Colors.blue,
}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(text),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.9,
              color: Colors.grey.shade500.withAlpha(190),
            ),
            borderRadius: BorderRadius.circular(10),
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

class WavyAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 80);
    final secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
