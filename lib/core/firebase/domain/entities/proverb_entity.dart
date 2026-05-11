class ProverbEntity {
  final String? id;
  final String text;
  final String reference;
  final String version;
  final String? addedAt;
  final String? reflexion;
  final int? sharedTimes;

  ProverbEntity({
    this.id,
    required this.text,
    required this.reference,
    required this.version,
    this.addedAt,
    this.reflexion,
    this.sharedTimes,
  });
}
