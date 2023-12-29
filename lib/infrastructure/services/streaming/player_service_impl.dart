// import 'package:get_it/get_it.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
// import '../../../application/services/streaming/player_service.dart';
// import 'custom_source.dart';

// class PlayerServiceImpl extends PlayerService {
//   late final AudioPlayer player;
//   final getIt = GetIt.instance;
//   late final MyCustomSource mySource;
//   bool firstTime = true;
//   Duration aux = Duration.zero;

//   @override
//   void initialize() {
//     player = AudioPlayer();
//     mySource = MyCustomSource();
//   }

//   @override
//   Future<void> pause() async {
//     await player.pause();
//   }

//   @override
//   Future<void> play() async {
//     await player.play();
//   }

//   @override
//   void seek() {}

//   @override
//   Future<void> setAudioSource(List<int> source) async {
//     final playerBloc = getIt.get<PlayerBloc>();
//     try {
//       mySource.addBytes(source);

//       player.positionStream.listen((position) {
//         if (position != Duration.zero && position > aux) {
//           aux = position;
//           print("posicion verificada ${position}");
//         }
//         print("position tracking ${position}");
//         playerBloc.add(TrackingCurrentPosition(position));
//       });

//       player.durationStream.listen((duration) {
//         playerBloc.add(UpdatingDuration(duration!));
//       });

//       await player.setAudioSource(mySource);
//       await player.load();
//       await player.seek(aux);

//       if (!player.playing) {
//         await player.play();
//       }
//     } on PlayerInterruptedException catch (e) {
//       print("Connection aborted: ${e.message}");
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Duration currentPosition() {
//     return player.position;
//   }
// }
