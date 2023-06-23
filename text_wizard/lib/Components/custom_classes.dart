import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tex_wiz/Components/ui_widgets.dart';
import 'package:tex_wiz/Constants/adjectives.dart';
import 'package:tex_wiz/Constants/adverbs.dart';
import 'package:tex_wiz/Constants/all_words.dart';
import 'package:tex_wiz/Constants/nouns.dart';
import 'package:tex_wiz/Constants/possessives.dart';
import 'package:tex_wiz/Constants/verbs.dart';
import 'package:translator/translator.dart';

import '../Constants/names.dart';

class TextUtilities {
  // 1 Singelton class
  static final TextUtilities _instance = TextUtilities._internal();

  factory TextUtilities() {
    return _instance;
  }

  TextUtilities._internal();

  // 1 Functions
  List<String> wordGenerator({
    String startWith = "",
    String endsWith = "",
    int wordCount = 1,
    int wordType = 0,
    int wordLength = 0,
    bool isSafeSearch = false,
  }) {
    List<String> results = [];
    List<String> words =
        filterWords(wordType: wordType, isSafeSearch: isSafeSearch);
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

  String sentenceGenerator({
    int wordType = 0,
    int sentenceLength = 1,
    int sentenceLines = 1,
    bool isSafeSearch = false,
    bool shouldAddCommas = false,
  }) {
    List<String> words =
        filterWords(wordType: wordType, isSafeSearch: isSafeSearch);
    String result = "";

    Random random = Random();
    int cnt = 1;
    int lowerBound = sentenceLines ~/ 2;
    int upperBound = sentenceLines - 3;
    bool previousWordIsPossessive = false;
    bool isCapitalWord = true;

    for (int i = 0; i < sentenceLength; i++) {
      String nextWord = "";

      if (random.nextBool() &&
          !previousWordIsPossessive &&
          i != sentenceLength - 1) {
        nextWord = allPossessive[random.nextInt(allPossessive.length)];
        previousWordIsPossessive = true;
      } else {
        nextWord = words[random.nextInt(words.length)];
        previousWordIsPossessive = false;
      }

      if (isCapitalWord) {
        nextWord = nextWord[0].toUpperCase() + nextWord.substring(1);
        isCapitalWord = false;
      }

      result += nextWord;

      if (i == sentenceLength - 1) {
        result += ".";
      } else if (shouldAddCommas &&
          !previousWordIsPossessive &&
          cnt == random.nextInt(upperBound) + lowerBound) {
        result += ",\n";
        cnt = 0;
      } else if (cnt == sentenceLines) {
        result += "\n";
        cnt = 0;
      } else {
        result += " ";
      }

      cnt++;
    }

    return result;
  }

  String passwordGenerator({
    bool includeNumbers = false,
    bool includeCapitalLetters = false,
    bool includeSymbols = false,
    int passwordLength = 8,
  }) {
    final random = Random();
    const specialCharacters = "!@#\$%&*_+?/,.\\";
    final sb = StringBuffer();

    for (int i = 0; i < passwordLength; i++) {
      if (includeNumbers && random.nextBool()) {
        // Include numbers
        sb.write(random.nextInt(10));
      } else if (includeCapitalLetters && random.nextBool()) {
        // Include capital letters
        sb.write(String.fromCharCode(random.nextInt(26) + 65));
      } else if (includeSymbols && random.nextBool()) {
        // Include symbols
        sb.write(specialCharacters[random.nextInt(specialCharacters.length)]);
      } else {
        // Include small letters
        sb.write(String.fromCharCode(random.nextInt(26) + 97));
      }
    }

    return sb.toString();
  }

  List<String> nameGenerator({
    String startWith = "",
    String endsWith = "",
    int nameCount = 1,
    int nameLength = 0,
  }) {
    List<String> results = [];
    List<String> words = allNames;
    // 1 Filter words based on conditions
    if (startWith.isNotEmpty || endsWith.isNotEmpty || nameLength != 0) {
      words = words.where((word) {
        bool startsWithCondition = startWith.isNotEmpty
            ? word.toLowerCase().startsWith(startWith)
            : true;
        bool endsWithCondition =
            endsWith.isNotEmpty ? word.toLowerCase().endsWith(endsWith) : true;
        bool wordLengthCondition =
            nameLength != 0 ? word.length == nameLength : true;
        return startsWithCondition && endsWithCondition && wordLengthCondition;
      }).toList();
    }
    if (words.isEmpty) {
      return [];
    }
    if (words.length < nameCount) {
      return words;
    }

    for (int i = 0; i < nameCount; i++) {
      results.add(words[Random().nextInt(words.length)]);
    }
    return results;
  }

  List<String> filterWords(
      {required int wordType, required bool isSafeSearch}) {
    List<String> words = [];
    // 1 Filter words based on wordType and Safe Word Search conditions
    switch (wordType) {
      // 1 All Words
      case 0:
        words = isSafeSearch ? allSafeWords : allWords.toSet().toList();
        break;
      // 2 Nouns
      case 1:
        words = isSafeSearch ? safeNounWords : allNouns.toSet().toList();
        break;
      // 3 Adjectives
      case 2: // Nouns
        words =
            isSafeSearch ? safeAdjectiveWords : allAdjectives.toSet().toList();
        break;
      // 4 Verbs
      case 3:
        words = isSafeSearch ? safeVerbWords : allVerbs.toSet().toList();
        break;
      // 5 Adverbs
      case 4:
        words = isSafeSearch ? safeAdverbWords : allAdverbs.toSet().toList();
        break;
      // Add more cases for other word types if needed
      default:
        words = isSafeSearch ? allSafeWords : allWords.toSet().toList();
        break;
    }
    return words;
  }

  Future<String> translateText({
    String text = "",
    String inputLanguage = 'auto',
    String outputLanguage = 'en',
  }) async {
    final translator = GoogleTranslator();
    try {
      var translation = await translator.translate(
        text,
        from: inputLanguage,
        to: outputLanguage,
      );
      return translation.text;
    } catch (e) {
      if (e.toString() == "Failed host lookup: 'translate.googleapis.com'") {
        return "Error: Please check your internet connection..";
      }
      return "Error: ${e.toString()}";
    }
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

  List<String> getWords({required String text, String textSplit = " "}) {
    List<String> words = [];
    // 1 Split text into words
    words = text.split(textSplit);
    // 2 Remove empty words
    words.removeWhere((word) => word.isEmpty);
    return words;
  }

  String textSplitter({
    required String text,
    String replaceWithText = "\n",
    String textPrefix = "",
    String textSuffix = "",
    String textSplit = " ",
  }) {
    List<String> words = getWords(text: text, textSplit: textSplit);
    // 1 Add prefix and suffix to words
    words = words.map((word) => "$textPrefix$word$textSuffix").toList();
    // 2 Join words with splitText
    return words.join(replaceWithText);
  }

  String duplicateRemover({
    required String text,
    double wordsToKeep = 1,
  }) {
    List<String> words = getWords(text: text);
    List<String> output = [];

    // 1 Count the occurrences of each word
    Map<String, int> wordCounts = {};
    for (var word in words) {
      if (wordCounts.containsKey(word)) {
        wordCounts[word] = wordCounts[word]! + 1;
        if (wordCounts[word]! <= wordsToKeep) {
          output.add(word);
        }
      } else {
        wordCounts[word] = 1;
        output.add(word);
      }
    }

    // 2 Filter words based on occurrence count

    // 3 Join words with a space
    return output.join(" ");
  }
}

class CustomDialogs {
  // 1 Singelton class
  static final CustomDialogs _instance = CustomDialogs._internal();
  factory CustomDialogs() {
    return _instance;
  }
  CustomDialogs._internal();

  // 1 Dialogs
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
}

class CustomNavigation {
  // 1 Singelton class
  static final CustomNavigation _instance = CustomNavigation._internal();

  factory CustomNavigation() {
    return _instance;
  }
  CustomNavigation._internal();
  // 1 Functions
  void navigateTo(
      {required BuildContext context, required Widget destination}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  void navigateAndReplace({
    required BuildContext context,
    required Widget destination,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => false,
    );
  }
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

class HomepageElement {
  String pageName;
  Widget pageWidget;
  IconData pageIcon;
  Color pageColor;
  HomepageElement({
    required this.pageName,
    required this.pageWidget,
    required this.pageIcon,
    required this.pageColor,
  });
}
