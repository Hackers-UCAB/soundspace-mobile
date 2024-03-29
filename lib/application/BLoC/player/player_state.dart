part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final List<double> waveForm;
  final List<Song> playlist;
  final Duration duration;
  final Duration bufferedDuration;
  final Duration position;
  final Duration seekPosition;
  final bool isInit;
  final bool isRefresh;
  final bool playbackState;
  final bool isUsed;
  final String currentIdSong;
  final String currentNameSong;
  final bool isLoading;
  final double volume;
  final double speed;
  final bool isFinished;
  final bool isConnected;

  const PlayerState(
      {this.seekPosition = Duration.zero,
      this.isLoading = false,
      this.playlist = const [],
      this.isRefresh = false,
      this.waveForm = const [0],
      this.isInit = false,
      this.currentIdSong = 'empty',
      this.currentNameSong = 'empty',
      this.duration = const Duration(seconds: 1),
      this.bufferedDuration = Duration.zero,
      this.position = Duration.zero,
      this.playbackState = false,
      this.isUsed = false,
      this.isFinished = true,
      this.isConnected = true,
      this.speed = 1.0,
      this.volume = 1.0});

  PlayerState copyWith(
          {bool? isLoading,
          List<double>? waveForm,
          List<Song>? playlist,
          bool? isInit,
          bool? userIsPlaying,
          String? currentIdSong,
          String? currentNameSong,
          Duration? duration,
          Duration? bufferedDuration,
          Duration? position,
          Duration? seekPosition,
          bool? playbackState,
          double? speed,
          double? volume,
          bool? isRefresh,
          bool? isFinished,
          bool? isConnected,
          bool? isUsed}) =>
      PlayerState(
          waveForm: waveForm ?? this.waveForm,
          playlist: playlist ?? this.playlist,
          isInit: isInit ?? this.isInit,
          currentIdSong: currentIdSong ?? this.currentIdSong,
          currentNameSong: currentNameSong ?? this.currentNameSong,
          duration: duration ?? this.duration,
          bufferedDuration: bufferedDuration ?? this.bufferedDuration,
          position: position ?? this.position,
          seekPosition: seekPosition ?? this.seekPosition,
          playbackState: playbackState ?? this.playbackState,
          isUsed: isUsed ?? this.isUsed,
          isRefresh: isRefresh ?? this.isRefresh,
          isLoading: isLoading ?? this.isLoading,
          speed: speed ?? this.speed,
          isConnected: isConnected ?? this.isConnected,
          isFinished: isFinished ?? this.isFinished,
          volume: volume ?? this.volume);

  @override
  List<Object> get props => [
        isInit,
        currentIdSong,
        currentNameSong,
        duration,
        bufferedDuration,
        position,
        playlist,
        seekPosition,
        playbackState,
        isFinished,
        isConnected,
        waveForm,
        isUsed,
        isLoading,
        volume,
        speed
      ];
}
