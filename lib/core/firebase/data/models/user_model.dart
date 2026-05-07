
import 'package:proverbiando/core/firebase/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String createdAt;
  final bool isAnonymous;
  final String lastSeen;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.isAnonymous,
    required this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: json['createdAt'],
      isAnonymous: json['isAnonymous'],
      lastSeen: json['lastSeen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'isAnonymous': isAnonymous,
      'lastSeen': lastSeen,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      createdAt: createdAt,
      isAnonymous: isAnonymous,
      lastSeen: lastSeen,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      createdAt: entity.createdAt,
      isAnonymous: entity.isAnonymous,
      lastSeen: entity.lastSeen,
    );
  }
}
