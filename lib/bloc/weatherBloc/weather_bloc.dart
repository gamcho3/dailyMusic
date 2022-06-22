import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:equatable/equatable.dart';
import '../../API/API_list.dart';
import '../../services/weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherAPI _weatherApi;
  final ConnectivityService _connectivityService;

  WeatherBloc(
    this._weatherApi,
    this._connectivityService,
  ) : super(WeatherLoadingState()) {
    _connectivityService.connectivityStream.stream.asBroadcastStream(
        onListen: ((subscription) {
      subscription.onData((data) {
        if (data == ConnectivityResult.none) {
          add(NetworkErrorEvent());
        } else {
          add(LoadWeatherEvent());
        }
      });
    }));

    // on<LoadWeatherEvent>((event, emit) async {
    //   emit(WeatherLoadingState());
    //   var result = await LocationAPI.determinePosition();
    //   print(result);
    //   // WeatherModel weather = await _weatherApi.getWeather(
    //   //     result?.latitude ?? 37.554197896721,
    //   //     result?.longitude ?? 127.19885348533894);

    //   emit(WeatherLoadedState(weather.main.temp, weather.weather[0].icon,
    //       weather.weather[0].main, weather.weather[0].description));
    // });

    on<NetworkErrorEvent>((event, emit) {
      emit(WeatherNetworkErrorState());
    });
  }
}
