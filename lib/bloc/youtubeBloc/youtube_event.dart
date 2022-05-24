part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class LoadApiEvent extends YoutubeEvent {
  final String keyword;
  const LoadApiEvent(this.keyword);
  @override
  List<String> get props => [];
}

class NetworkErrorEvent extends YoutubeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
