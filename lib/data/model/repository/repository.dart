import '../prov_model.dart';

abstract class Repository {

  Future<ProvModel?> provGet();

}