import '../city_model.dart';
import '../prov_model.dart';
import '../weather_5day_model.dart';
import '../weather_now_model.dart';

abstract class Repository {

  Future<ProvModel?> provGet();
  Future<CityModel?> cityGet(String idProv);

  Future<WeatherNowModel?> weatherNowGet(String city);
  Future<Weather5DayModel?> weather5DayGet(String city);
}