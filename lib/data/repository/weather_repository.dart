import 'package:daliy_music/data/remote_datasource/remote_data_source.dart';

import '../models/weather.dart';

class WeatherRepository {
  Future<WeatherModel?> obtainWeather() async {
    var result = await RemoteDataSource.determinePosition();
    if (result != null) {
      WeatherModel data =
          await RemoteDataSource.getWeather(result.latitude, result.longitude);
      return data;
    }
    return null;
  }
}
