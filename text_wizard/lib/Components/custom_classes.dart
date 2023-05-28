import 'dart:math';

import 'package:text_wizard/Constants/adjectives.dart';
import 'package:text_wizard/Constants/adverbs.dart';
import 'package:text_wizard/Constants/all_words.dart';
import 'package:text_wizard/Constants/nouns.dart';
import 'package:text_wizard/Constants/verbs.dart';

class CustomWordGenerator {
  List<String> wordGenerator({
    String startWith = "",
    String endsWith = "",
    int wordCount = 1,
    int wordType = 0,
    int wordLength = 0,
    bool isSafeSearch = false,
  }) {
    List<String> words = [];
    List<String> results = [];
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
    List<String> words = [];
    String result = "";
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
    // 1 Filter Sentence based on conditions
    int cnt = 1;
    int lowerBound = (sentenceLines ~/ 2) - 2;
    int upperBound = (sentenceLines ~/ 2) + 2;
    for (int i = 0; i < sentenceLength; i++) {
      result += "${words[Random().nextInt(words.length)]} ";
      if (i == sentenceLength - 1) {
        result += ".";
      }
      if (shouldAddCommas &&
          cnt == sentenceLines &&
          cnt == Random().nextInt(upperBound - lowerBound + 1) + lowerBound) {
        result += ",\n";
        cnt = 0;
      }
      if (cnt == sentenceLines) {
        result += "\n";
        cnt = 0;
      }
      cnt++;
    }
    return result;
  }
}
