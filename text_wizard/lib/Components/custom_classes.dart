import 'dart:math';

import 'package:word_generator/data/nouns.dart';
import 'package:word_generator/word_generator.dart';

class WordGeneratorPlus extends WordGenerator {
  String randomNounPlus({String startsWith = "", String endsWith = ""}) {
    final random = Random();
    final filteredNouns = nouns
        .where((noun) => noun.startsWith(startsWith) && noun.endsWith(endsWith))
        .toList();
    if (filteredNouns.isEmpty) {
      return ""; // Return an empty string if no matching word is found
    }

    return filteredNouns[random.nextInt(filteredNouns.length)];
  }
}
