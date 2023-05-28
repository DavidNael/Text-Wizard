import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_wizard/Constants/adjectives.dart';
import 'package:text_wizard/Constants/all_words.dart';
import 'package:text_wizard/Constants/nouns.dart';
import 'package:text_wizard/Constants/verbs.dart';

import '../Constants/adverbs.dart';

List<String> wordGenerator({
  String startWith = "",
  String endsWith = "",
  int wordCount = 1,
  int wordType = 0,
  int wordLength = 0,
}) {
  List<String> words = [];
  List<String> results = [];
  // Filter words based on wordType condition
  switch (wordType) {
    // 1 All Words
    case 0:
      words = allWords.toSet().toList();
      break;
    // 2 Nouns
    case 1:
      words = allNouns.toSet().toList();
      break;
    // 3 Adjectives
    case 2: // Nouns
      words = allAdjectives.toSet().toList();
      break;
    // 4 Verbs
    case 3:
      words = allVerbs.toSet().toList();
      break;
    // 5 Adverbs
    case 4:
      words = allAdverbs.toSet().toList();
      break;
    // Add more cases for other word types if needed
    default:
      words = allWords.toSet().toList();
      break;
  }

  // 1 Filter words based on conditions
  if (startWith.isNotEmpty || endsWith.isNotEmpty || wordLength != 0) {
    words = words.where((word) {
      bool startsWithCondition =
          startWith.isNotEmpty ? word.startsWith(startWith) : true;
      bool endsWithCondition =
          endsWith.isNotEmpty ? word.endsWith(endsWith) : true;
      bool wordLengthCondition =
          wordLength != 0 ? word.length == wordLength : true;
      return startsWithCondition && endsWithCondition && wordLengthCondition;
    }).toList();
  }
  if (words.isEmpty) {
    return [];
  }
  if (words.length < wordCount) {
    return words;
  }

  for (int i = 0; i < wordCount; i++) {
    results.add(words[Random().nextInt(words.length)]);
  }
  return results;
}

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
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
          ),
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
                child: const Center(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
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
        title: const Column(
          children: [
            Text(
              "Loading...",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(),
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
