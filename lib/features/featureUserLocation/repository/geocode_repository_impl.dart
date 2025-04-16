import 'package:dio/dio.dart';
import 'package:wdywtg/core/openCage/open_cage_client.dart';
import 'geocode_repository.dart';

class GeocodeRepositoryImpl extends GeocodeRepository {

  final _openCageClient = OpenCageClient(Dio());

  @override
  void dispose() {}

}