import 'package:bloc/bloc.dart';
import 'package:daliy_music/model/weather/weather.dart';
import 'package:equatable/equatable.dart';

import '../API/API_list.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherAPI _weatherApi;
  WeatherBloc(this._weatherApi) : super(WeatherLoadingState()) {
    on<WeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      var result = await LocationAPI.determinePosition();
      WeatherModel weather =
          await _weatherApi.getWeather(result.latitude, result.longitude);
      emit(WeatherLoadedState(weather.main.temp, weather.weather[0].icon,
          weather.weather[0].main, weather.weather[0].description));
    });
  }
}
