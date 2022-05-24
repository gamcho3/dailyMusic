part of 'youtube_bloc.dart';

abstract class YoutubeState extends Equatable {
  const YoutubeState();
}

class YoutubeLoadingState extends YoutubeState {
  @override
  List<Object> get props => [];
}

class YoutubeLoadedState extends YoutubeState {
  //var youtubeModel = YoutubeListModel;
  final List<Item> items;
  const YoutubeLoadedState(
    this.items,
  );
  @override
  List<Item> get props => items;
}

class YoutubeNetworkErrorState extends YoutubeState {
  @override
  List<Object> get props => [];
}
