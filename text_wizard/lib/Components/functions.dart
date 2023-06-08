import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';

Future<dynamic> customShowDialog({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: customText(
          text: title,
        ),
        content: customText(
          text: title,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onPressed != null ? onPressed() : null;
                },
                child: Center(
                  child: customText(
                    text: title,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> customLoadingDialog({
  required BuildContext context,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            customText(
              text: "Loading...",
            ),
            const SizedBox(
              height: 30,
            ),
            const CircularProgressIndicator(),
          ],
        ),
        // actions: [],
      );
    },
  );
}

void copyToClipboard({String text = ""}) {
  if (text.isEmpty) {
    Fluttertoast.showToast(
      msg: "No Words to copy.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
    return;
  }
  Clipboard.setData(
    ClipboardData(
      text: text,
    ),
  );
  Fluttertoast.showToast(
    msg: "Copied to clipboard.",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
  );
}

void shareText({String text = ""}) {
  text.isEmpty
      ? Fluttertoast.showToast(
          msg: "No Words to share.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        )
      : Share.share(text);
}
