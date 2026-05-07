import 'package:proverbiando/core/firebase/domain/entities/proverb_entity.dart';

class ProverbModelFromFirebase {
  final String text;
  final String reference;
  final String version;
  final String? addedAt;
  final String? reflexion;
  final int? sharedTimes;

  ProverbModelFromFirebase({
    required this.text,
    required this.reference,
    required this.version,
    this.addedAt,
    this.reflexion,
    this.sharedTimes,
  });

  factory ProverbModelFromFirebase.fromJson(Map<String, dynamic> json) {
    return ProverbModelFromFirebase(
      text: json['text'],
      reference: json['reference'],
      version: json['version'],
      addedAt: json['addedAt'],
      reflexion: json['reflexion'],
      sharedTimes: json['sharedTimes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'reference': reference,
      'version': version,
      'addedAt': addedAt ?? '',
      'reflexion': reflexion ?? '',
      'sharedTimes': sharedTimes ?? 0,
    };
  }

  ProverbEntity toEntity() {
    return ProverbEntity(
      text: text,
      reference: reference,
      version: version,
      addedAt: addedAt,
      reflexion: reflexion,
      sharedTimes: sharedTimes,
    );
  }

  factory ProverbModelFromFirebase.fromEntity(ProverbEntity proverb) {
    return ProverbModelFromFirebase(
      text: proverb.text,
      reference: proverb.reference,
      version: proverb.version,
      addedAt: proverb.addedAt,
      reflexion: proverb.reflexion,
      sharedTimes: proverb.sharedTimes,
    );
  }
}
