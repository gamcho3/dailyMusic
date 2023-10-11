import 'package:daily_music/config/di.dart';
import 'package:daily_music/data/remote_datasource/remote_data_source.dart';
import 'package:get_it/get_it.dart';

class WeatherRepository {
  final RemoteDataSource _remoteDataSource;

  WeatherRepository({RemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? getit.get<RemoteDataSource>();

  // Future<WeatherModel?> obtainWeather() async {
  //   var result = await _remoteDataSource.determinePosition();
  //   if (result != null) {
  //     WeatherModel data =
  //         await _remoteDataSource.getWeather(result.latitude, result.longitude);
  //     return data;
  //   }
  //   return null;
  // }
}
