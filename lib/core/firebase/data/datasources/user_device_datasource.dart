import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proverbiando/core/firebase/data/models/user_device_model.dart';

abstract class UserDeviceDatasource {
  Future<void> upsertDevice({
    required String userId,
    required UserDeviceModel device,
  });
}

class UserDeviceDatasourceImpl implements UserDeviceDatasource {
  UserDeviceDatasourceImpl(this.firestore);

  final FirebaseFirestore firestore;
  late final userCollection = firestore.collection('users');

  @override
  Future<void> upsertDevice({
    required String userId,
    required UserDeviceModel device,
  }) async {
    final deviceRef = userCollection
        .doc(userId)
        .collection('devices')
        .doc(device.installationId);

    final snapshot = await deviceRef.get();
    final payload = {
      ...device.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
      if (!snapshot.exists) 'createdAt': FieldValue.serverTimestamp(),
    };

    await deviceRef.set(payload, SetOptions(merge: true));
  }
}
