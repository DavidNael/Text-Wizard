import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_wizard/Constants/adjectives.dart';
import 'package:text_wizard/Constants/adverbs.dart';
import 'package:text_wizard/Constants/all_words.dart';
import 'package:text_wizard/Constants/nouns.dart';
import 'package:text_wizard/Constants/possessives.dart';
import 'package:text_wizard/Constants/verbs.dart';

class TextUtilities {
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

