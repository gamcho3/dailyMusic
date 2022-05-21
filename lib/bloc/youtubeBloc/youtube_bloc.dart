import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:equatable/equatable.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  final YoutubeList _youtubeList;
  final ConnectivityService _connectivityService;
  YoutubeBloc(this._youtubeList, this._connectivityService)
      : super(YoutubeLoadingState()) {
    on<YoutubeEvent>((event, emit) {
      _connectivityService.connectivityStream.stream.listen((event) {
        if (event == ConnectivityResult.none) {
          add(NetworkErrorEvent());
        } else {
          add(LoadApiEvent());
        }
      });
    });
  }
}
