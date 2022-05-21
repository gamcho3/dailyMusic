part of 'youtube_bloc.dart';

abstract class YoutubeState extends Equatable {
  const YoutubeState();
}

class YoutubeLoadingState extends YoutubeState {
  @override
  List<Object> get props => [];
}
