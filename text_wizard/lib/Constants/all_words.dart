import 'package:text_wizard/Constants/adjectives.dart';
import 'package:text_wizard/Constants/adverbs.dart';
import 'package:text_wizard/Constants/nouns.dart';
import 'package:text_wizard/Constants/possessives.dart';
import 'package:text_wizard/Constants/verbs.dart';

final List<String> allSafeWords = safeNounWords +
    safeAdjectiveWords +
    safeVerbWords +
    safeAdverbWords +
    allPossessive;

final List<String> allUnsafeWords = unsafeNounWords +
    unsafeAdjectiveWords +
    unsafeVerbWords +
    unsafeAdverbWords;

final List<String> allWords = allSafeWords + allUnsafeWords;
