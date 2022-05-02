part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final double temperture;
  final String weatherIcon;
  final String weatherStatus;
  final String weatherDescription;
  const WeatherLoadedState(this.temperture, this.weatherIcon,
      this.weatherStatus, this.weatherDescription);
  @override
  List<Object?> get props =>
      [temperture, weatherIcon, weatherStatus, weatherDescription];
}
