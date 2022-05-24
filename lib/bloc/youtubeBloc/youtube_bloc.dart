import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:equatable/equatable.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeServices _youtubeList;
  final ConnectivityService _connectivityService;
  YoutubeBloc(this._youtubeList, this._connectivityService)
      : super(YoutubeLoadingState()) {
    _connectivityService.connectivityStream.stream.asBroadcastStream(
        onListen: ((subscription) {
      subscription.onData((data) {
        if (data == ConnectivityResult.none) {
          add(NetworkErrorEvent());
        } else {
          add(LoadApiEvent('bts'));
        }
      });
    }));

    on<LoadApiEvent>((event, emit) async {
      //print(event.props[0]);
      emit(YoutubeLoadingState());

      YoutubeListModel youtubeListModel =
          await _youtubeList.getYoutubeData(keyword: 'bts');
      emit(YoutubeLoadedState(youtubeListModel.items));
    });

    on<NetworkErrorEvent>((event, emit) {
      emit(YoutubeNetworkErrorState());
    });
  }
}
