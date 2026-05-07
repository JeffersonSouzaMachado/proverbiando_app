import 'package:proverbiando/features/home/data/models/proverb_model_from_api.dart';
import 'package:dio/dio.dart';

abstract class ProverbRemoteDatasource {
  Future<ProverbModelFromApi> getRandomProverb();
}

class ProverbRemoteDatasourceImpl implements ProverbRemoteDatasource {
  final Dio dio;

  ProverbRemoteDatasourceImpl(this.dio);

  @override
  Future<ProverbModelFromApi> getRandomProverb() async {
    final response = await dio.get(
      'https://bible-api.com/data/almeida/random/PRO',
    );
    return ProverbModelFromApi.fromJson(response.data);
  }
}
