import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proverbiando/core/firebase/data/models/app_config_model.dart';

abstract class AppConfigFirebaseDatasource {
  Future<AppConfigModel> getAppConfig({required String actualOs});
}

class AppConfigFirebaseDatasourceImpl extends AppConfigFirebaseDatasource {
  final FirebaseFirestore firestore;

  AppConfigFirebaseDatasourceImpl(this.firestore);

  late final appConfigCollection = firestore.collection('app_config');

  @override
  Future<AppConfigModel> getAppConfig({required String actualOs}) async {
    final doc = await appConfigCollection.doc(actualOs).get();

    final data = doc.data();

    if (data == null) {
      throw Exception('Configuração não encontrada para o sistema: $actualOs');
    }
    final appConfig = AppConfigModel.fromJson(data);

    return appConfig;
  }
}
