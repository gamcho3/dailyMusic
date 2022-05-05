part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class LoadApiEvent extends WeatherEvent {
  @override
  List<Object> get props => [];
}

class NetworkErrorEvent extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
