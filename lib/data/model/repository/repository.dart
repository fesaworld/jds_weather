import '../city_model.dart';
import '../prov_model.dart';

abstract class Repository {

  Future<ProvModel?> provGet();
  Future<CityModel?> cityGet(String idProv);

}