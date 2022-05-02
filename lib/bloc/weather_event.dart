part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class LoadApiEvent extends WeatherEvent {
  @override
  List<Object> get props => [];
}
