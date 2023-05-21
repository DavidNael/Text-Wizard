import 'package:flutter/material.dart';

import 'logic_widgets.dart';

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
