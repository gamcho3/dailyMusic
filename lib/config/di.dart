import 'package:daily_music/data/local_datasource/local_data_source.dart';
import 'package:daily_music/data/remote_datasource/remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final GetIt getit = GetIt.instance;

void setupGetIt() {
  getit.registerSingleton<RemoteDataSource>(RemoteDataSource());
  getit.registerSingleton<LocalDataSource>(LocalDataSource());
}
