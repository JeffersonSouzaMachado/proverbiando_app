import 'package:proverbiando/core/firebase/domain/entities/user_device_entity.dart';

abstract class UserDeviceRepository {
  Future<void> upsertDevice({
    required String userId,
    required UserDeviceEntity device,
  });
}
