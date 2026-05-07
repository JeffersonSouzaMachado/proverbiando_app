class UserEntity {
  final String id;
  final String createdAt;
  final bool isAnonymous;
  final String lastSeen;

  UserEntity({
    required this.id,
    required this.createdAt,
    required this.isAnonymous,
    required this.lastSeen,
  });
}
