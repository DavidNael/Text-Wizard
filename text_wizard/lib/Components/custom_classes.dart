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

  List<String> getWords({
    required String text,
    String textSplit = " ",
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
    bool getLines = false,
  }) {
    List<String> words = [];
    // 1 Split text into words
    if (ignoreNewLines) {
      words = text.split(RegExp(r' |\n'));
    } else if (getLines) {
      words = text.split("\n");
      print(words);
    } else {
      final newString = text.replaceAll("\n", " \n ");
      words = newString.split(" ");
    }
    // 2 Remove empty words
    if (ignoreSpaces) {
      words.removeWhere((word) => word.isEmpty);
    }
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
        } else if (wordsToKeep == 0) {
          output.remove(word);
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

  String caseConverter({
    String text = "",
    int inputCaseType = 0,
    int outputCaseType = 1,
  }) {
    List<String> textList = getWords(text: text);
    String result = "";
    switch (outputCaseType) {
      // 1 Lower Case
      case 0:
        {
          result = text.toLowerCase();
          break;
        }
      // 2 Upper Case
      case 1:
        {
          result = text.toUpperCase();
          break;
        }
      // 3 Title Case
      case 2:
        {
          List<String> exceptionWords = [
            'a',
            'an',
            'the',
            'and',
            'or',
            'but',
            'in',
            'on',
            'for',
            'up',
            "to",
            "with",
            "by",
            "from",
            "of",
          ];

          for (int i = 0; i < textList.length; i++) {
            if (textList[i].isNotEmpty &&
                !exceptionWords.contains(textList[i].toLowerCase())) {
              textList[i] =
                  textList[i][0].toUpperCase() + textList[i].substring(1);
            }
          }
          result = textList.join(" ");
          break;
        }
      // 4 Sentence Case
      case 3:
        {
          for (int i = 0; i < textList.length; i++) {
            if (textList[i].isNotEmpty) {
              textList[i] = textList[i][0].toUpperCase() +
                  textList[i].substring(1).toLowerCase();
            }
          }
          result = textList.join('. ');
          break;
        }
      // 5 Alternating Case
      case 4:
        {
          for (int i = 0; i < textList.length; i++) {
            String word = textList[i];
            List<String> characters = word.split('');

            for (int j = 0; j < characters.length; j++) {
              if (j % 2 == 0) {
                characters[j] = characters[j].toUpperCase();
              } else {
                characters[j] = characters[j].toLowerCase();
              }
            }

            textList[i] = characters.join('');
          }

          result = textList.join(' ');
          break;
        }
      // 6 Random Case
      case 5:
        {
          for (int i = 0; i < textList.length; i++) {
            String word = textList[i];
            List<String> characters = word.split('');
            for (int j = 0; j < characters.length; j++) {
              bool isUpperCase = Random().nextBool();
              if (isUpperCase) {
                characters[j] = characters[j].toUpperCase();
              } else {
                characters[j] = characters[j].toLowerCase();
              }
            }

            textList[i] = characters.join('');
          }

          result = textList.join(' ');
          break;
        }
      // 7 Camel Case
      case 6:
        {
          for (int i = 0; i < textList.length; i++) {
            if (i != 0) {
              textList[i] =
                  textList[i][0].toUpperCase() + textList[i].substring(1);
            }
          }
          result = textList.join("");
          break;
        }
      // 8 Snake Case
      case 7:
        {
          result = text.replaceAll(' ', '_').toLowerCase();
          break;
        }
      // 9 Kebab Case
      case 8:
        {
          result = text.replaceAll(' ', '-').toLowerCase();
          break;
        }
      // 10 Pascal Case
      case 9:
        {
          for (int i = 0; i < textList.length; i++) {
            textList[i] =
                textList[i][0].toUpperCase() + textList[i].substring(1);
          }
          result = textList.join("");
          break;
        }
    }
    return result;
  }

  String lineLimiter({
    String text = "",
    int limit = 10,
    bool shouldCutWord = false,
  }) {
    List<String> words = getWords(text: text);
    String result = "";
    int currentLineLength = 0;
    for (int i = 0; i < words.length; i++) {
      int addingWordLength = (currentLineLength + words[i].length);
      int wordLength = words[i].length;
      if (addingWordLength < limit) {
        result += "${words[i]} ";
        currentLineLength += wordLength + 1;
      } else if (addingWordLength == limit) {
        result += "${words[i]}\n";
        currentLineLength = 0;
      } else {
        if (shouldCutWord) {
          int cutOffset = limit - currentLineLength;
          result += "${words[i].substring(0, cutOffset)}\n";
          int currentOffset = cutOffset;
          int afterCutWordLength = wordLength - cutOffset;
          for (int j = 0; j < (afterCutWordLength + limit) ~/ limit; j++) {
            if (currentOffset + limit < wordLength) {
              result +=
                  "${words[i].substring(currentOffset, currentOffset + limit)}\n";
              currentOffset += limit;
            } else if (afterCutWordLength % limit == 0) {
              result += "${words[i].substring(currentOffset)}\n";
              currentLineLength = 0;
              break;
            } else {
              result += "${words[i].substring(currentOffset)} ";
              currentLineLength = (afterCutWordLength % limit) + 1;
              break;
            }
          }
        } else {
          result += currentLineLength != 0 ? "\n${words[i]} " : "${words[i]} ";
          currentLineLength = wordLength;
        }
      }
    }
    return result;
  }

  String reverseText({
    String text = "",
    bool reverseCharacters = false,
    bool ignoreSpaces = true,
    bool ignoreNewLines = true,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      ignoreNewLines: ignoreNewLines,
    );
    String result = "";
    for (int i = words.length - 1; i >= 0; i--) {
      if (reverseCharacters) {
        List<String> characters = words[i].split('');
        characters = characters.reversed.toList();
        words[i] = characters.join('');
      }
      result += words[i] == '\n' ? words[i] : "${words[i]} ";
    }
    return result;
  }

  String textRemover({
    String text = "",
    String key = "",
    bool caseSensitive = false,
    bool matchKey = false,
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      ignoreNewLines: ignoreNewLines,
    );
    String result = "";
    String currentKey = caseSensitive ? key : key.toLowerCase();
    for (int i = 0; i < words.length; i++) {
      String currentWord = caseSensitive ? words[i] : words[i].toLowerCase();
      if (currentWord != currentKey) {
        if (matchKey || (!matchKey && !currentWord.contains(currentKey))) {
          result += "${words[i]} ";
        }
      }
    }
    return result;
  }

  String replaceText({
    String text = "",
    String key = "",
    String newKey = "",
    bool caseSensitive = false,
  }) {
    String result = "";

    RegExp regex = RegExp(key, caseSensitive: caseSensitive);
    result = text.replaceAll(regex, newKey);

    return result;
  }

  String spaceIncreaser(
      {String text = "", int increaseValue = 1, bool ignoreSpaces = false}) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
    );
    String result = "";
    for (int i = 0; i < words.length; i++) {
      result += words[i];
      if (i != words.length - 1) {
        for (int j = 0; j < increaseValue + 1; j++) {
          result += " ";
        }
      }
    }
    return result;
  }

  bool isAlphabetical(int char) {
    final lowerChar = String.fromCharCode(char).toLowerCase();
    return (lowerChar.codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
        lowerChar.codeUnitAt(0) <= 'z'.codeUnitAt(0));
  }

  bool isNumber(int char) {
    final lowerChar = String.fromCharCode(char).toLowerCase();
    return (lowerChar.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        lowerChar.codeUnitAt(0) <= '9'.codeUnitAt(0));
  }

  String formatText({String text = "", int option = 0}) {
    switch (option) {
      // 1 Bold
      case 0:
        {
          final boldText = StringBuffer();
          for (var char in text.runes) {
            if (isAlphabetical(char)) {
              boldText
                  .write(String.fromCharCode(0x1D5D4 + char - 'a'.runes.first));
            } else if (isNumber(char)) {
              boldText
                  .write(String.fromCharCode(0x1D7CE + char - '0'.runes.first));
            } else {
              boldText.write(String.fromCharCode(char));
            }
          }
          return boldText.toString();
        }
    }
    return text;
  }

  String textSorter({
    String text = "",
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      ignoreNewLines: ignoreNewLines,
      getLines: true,
    );
    words.sort();
    String result = "";
    for (int i = 0; i < words.length; i++) {
      if (ignoreNewLines) {
        result += "${words[i]} ";
      } else if (ignoreSpaces) {
        final newWords = words[i].replaceAll(RegExp(r'\s+'), ' ').trim();
        result += "$newWords\n";
      } else {
        result += "${words[i]}\n";
      }
    }
    return result;
  }

  String textRandomizer({
    String text = "",
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      ignoreNewLines: ignoreNewLines,
      getLines: true,
    );
    words.shuffle();
    String result = "";
    for (int i = 0; i < words.length; i++) {
      if (ignoreNewLines) {
        result += "${words[i]} ";
      } else if (ignoreSpaces) {
        final newWords = words[i].replaceAll(RegExp(r'\s+'), ' ').trim();
        result += "$newWords\n";
      } else {
        result += "${words[i]}\n";
      }
    }
    return result;
  }

  String textPrefixer({
    String text = "",
    String prefix = "",
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      getLines: ignoreNewLines,
    );
    // print(words);
    String result = "";

    for (int i = 0; i < words.length; i++) {
      if (ignoreNewLines) {
        if (ignoreSpaces) {
          final newWord = words[i].replaceAll(RegExp(r'\s+'), ' ').trim();
          result += "$prefix$newWord\n";
        } else {
          result += "$prefix${words[i]}\n";
        }
      } else {
        result += "$prefix${words[i]} ";
      }
    }
    return result;
  }

  String textSuffixer({
    String text = "",
    String suffix = "",
    bool ignoreSpaces = false,
    bool ignoreNewLines = false,
  }) {
    List<String> words = getWords(
      text: text,
      ignoreSpaces: ignoreSpaces,
      getLines: ignoreNewLines,
    );
    String result = "";

    for (int i = 0; i < words.length; i++) {
      if (ignoreNewLines) {
        if (ignoreSpaces) {
          final newWord = words[i].replaceAll(RegExp(r'\s+'), ' ').trim();
          result += "$newWord$suffix\n";
        } else {
          result += "${words[i]}$suffix\n";
        }
      } else {
        result += "${words[i]}$suffix ";
      }
    }
    return result;
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
  IconData? pageIcon2;
  Color pageColor;
  HomepageElement({
    required this.pageName,
    required this.pageWidget,
    required this.pageIcon,
    required this.pageColor,
    this.pageIcon2,
  });
}
