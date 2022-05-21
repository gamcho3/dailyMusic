part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class LoadApiEvent extends YoutubeEvent {
  @override
  List<Object> get props => [];
}

class NetworkErrorEvent extends YoutubeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
