part of 'youtube_bloc.dart';

abstract class YoutubeEvent extends Equatable {
  const YoutubeEvent();
}

class LoadYoutubeEvent extends YoutubeEvent {
  final String keyword;
  const LoadYoutubeEvent(this.keyword);
  @override
  List<Object> get props => [keyword];
}

class NetworkErrorEvent extends YoutubeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
