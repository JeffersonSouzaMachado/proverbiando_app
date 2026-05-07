//
// {
// "translation": {
// "identifier": "almeida",
// "name": "João Ferreira de Almeida",
// "language": "Portuguese",
// "language_code": "por",
// "license": "Public Domain"
// },
// "random_verse": {
// "book_id": "PRO",
// "book": "Provérbios",
// "chapter": 19,
// "verse": 27,
// "text": "Cessa, filho meu, de ouvir a instrução, e logo te desviarás das palavras do conhecimento.   "
// }
// }


import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';

class TranslationModel {
  final String identifier;
  final String name;
  final String language;
  final String languageCode;
  final String license;

  TranslationModel({
    required this.identifier,
    required this.name,
    required this.language,
    required this.languageCode,
    required this.license,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      identifier: json['identifier'],
      name: json['name'],
      language: json['language'],
      languageCode: json['language_code'],
      license: json['license'],
    );
  }
}

class RandomVerseModel {
  final String bookId;
  final String book;
  final int chapter;
  final int verse;
  final String text;

  RandomVerseModel({
    required this.bookId,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory RandomVerseModel.fromJson(Map<String, dynamic> json) {
    return RandomVerseModel(
      bookId: json['book_id'],
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
      text: json['text'],
    );
  }
}

class ProverbModelFromApi {
  final TranslationModel translationModel;
  final RandomVerseModel randomVerseModel;

  ProverbModelFromApi({
    required this.translationModel,
    required this.randomVerseModel,
  });

  factory ProverbModelFromApi.fromJson(Map<String, dynamic> json) {
    return ProverbModelFromApi(
      translationModel: TranslationModel.fromJson(json['translation']),
      randomVerseModel: RandomVerseModel.fromJson(json['random_verse']),
    );
  }

  ProverbEntity toEntity() {
    return ProverbEntity(
      text: _normalizeText(randomVerseModel.text),
      version: translationModel.name.trim(),
      reference:
          '${randomVerseModel.book} ${randomVerseModel.chapter}:${randomVerseModel.verse}',
    );
  }
}

String _normalizeText(String text) {
  var normalized = text.trim();

  if (normalized.endsWith(',')) {
    normalized = normalized.substring(0, normalized.length - 1).trim();
  }

  if (normalized.isEmpty) return normalized;

  return normalized[0].toUpperCase() + normalized.substring(1);
}