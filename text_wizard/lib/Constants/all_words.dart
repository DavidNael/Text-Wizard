import 'package:tex_wiz/Constants/adjectives.dart';
import 'package:tex_wiz/Constants/adverbs.dart';
import 'package:tex_wiz/Constants/nouns.dart';
import 'package:tex_wiz/Constants/possessives.dart';
import 'package:tex_wiz/Constants/verbs.dart';

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
