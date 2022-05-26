import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:equatable/equatable.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeServices _youtubeList;

  YoutubeBloc(
    this._youtubeList,
  ) : super(YoutubeLoadingState()) {
    on<LoadYoutubeEvent>(_onLoadYoutube);

    on<NetworkErrorEvent>((event, emit) {
      emit(YoutubeNetworkErrorState());
    });
  }
  void _onLoadYoutube(
      LoadYoutubeEvent event, Emitter<YoutubeState> emit) async {
    emit(YoutubeLoadingState());

    YoutubeListModel youtube =
        await _youtubeList.getYoutubeData(keyword: event.keyword);

    emit(YoutubeLoadedState(items: youtube.items));
  }
}
