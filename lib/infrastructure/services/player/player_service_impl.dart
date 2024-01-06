import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/infrastructure/services/player/custom_source.dart';
import '../../../application/services/player/player_services.dart';

class PlayerServiceImpl extends PlayerService {
  late final AudioPlayer player;
  final getIt = GetIt.instance;
  late final MyCustomSource mySource;
  Duration aux = Duration.zero;

  @override
  void initialize() {
    player = AudioPlayer();
    mySource = MyCustomSource();
    trackingDuration();
    trackingPosition();
    trackingState();
  }

  @override
  Future<void> pause() async {
    if (player.playing) {
      await player.pause();
    }
  }

  @override
  Future<void> play() async {
    if (!player.playing) {
      await player.play();
    }
  }

  @override
  void seek(Duration duration) {
    player.seek(duration);
  }

  @override
  Future<void> setAudioSource(List<int> source) async {
    try {
      mySource.addBytes(source);

      await player.setAudioSource(mySource);
      await player.load();
      if (player.position < aux) {
        await player.seek(aux);
      }

      play();
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void reset() {
    seek(Duration.zero);
    pause();
  }

  @override
  void trackingDuration() {
    final playerBloc = getIt.get<PlayerBloc>();
    player.durationStream.listen((duration) {
      playerBloc.add(UpdatingDuration(duration!));
    });
  }

  @override
  void trackingPosition() {
    final playerBloc = getIt.get<PlayerBloc>();
    player.positionStream.listen((position) {
      if (position != Duration.zero && position > aux) {
        aux = position;
        print("posicion verificada ${position}");
      }

      if (position == Duration.zero) {
        seek(aux);
      }
      print("position tracking ${position}");
      playerBloc.add(TrackingCurrentPosition(position));
    });
  }

  @override
  void trackingState() {
    final playerBloc = getIt.get<PlayerBloc>();
    player.playerStateStream.listen((event) {
      playerBloc.add(PlayerPlaybackStateChanged(event.playing));
    });
  }
}
