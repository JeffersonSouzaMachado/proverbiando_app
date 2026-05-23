import 'package:proverbiando/core/firebase/data/datasources/user_device_datasource.dart';
import 'package:proverbiando/core/firebase/data/models/user_device_model.dart';
import 'package:proverbiando/core/firebase/domain/entities/user_device_entity.dart';
import 'package:proverbiando/core/firebase/domain/repositories/user_device_repository.dart';

class UserDeviceRepositoryImpl implements UserDeviceRepository {
  UserDeviceRepositoryImpl(this.datasource);

  final UserDeviceDatasource datasource;

  @override
  Future<void> upsertDevice({
    required String userId,
    required UserDeviceEntity device,
  }) {
    return datasource.upsertDevice(
      userId: userId,
      device: UserDeviceModel.fromEntity(device),
    );
  }
}
