import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_bloc/application/BLoC/gps/gps_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/notifications/notifications_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_trending_albums_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/artist/get_trending_artists_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/playlist/get_trending_playlists_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/song/get_trending_songs_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/user/get_user_local_data_use_case.dart';
import 'package:sign_in_bloc/application/use_cases/user/subscribe_use_case.dart';
import 'package:sign_in_bloc/infrastructure/repositories/album/album_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/artist/artist_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/promotional_banner/promotional_banner_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/song/song_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/datasources/api/api_connection_manager_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/internet_connection/connection_manager_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/config/firebase/firebase_options.dart';
import 'package:sign_in_bloc/infrastructure/datasources/local/local_storage_impl.dart';
import '../../../application/BLoC/connectivity/connectivity_bloc.dart';
import '../../../application/BLoC/logInSubs/log_in_subscriber_bloc.dart';
import '../../../application/BLoC/trendings/trendings_bloc.dart';
import '../../../application/use_cases/promotional_banner/get_promotional_banner_use_case.dart';
import '../../../application/use_cases/user/log_in_use_case.dart';
import '../../presentation/config/router/app_router.dart';
import '../../repositories/playlist/playlist_repository_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../foreground_notifications/local_notifications_impl.dart';
import '../streaming/socket_client_impl.dart';
import '../location/location_manager_impl.dart';

class InjectManager {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  static Future<void> setUpInjections() async {
    WidgetsFlutterBinding.ensureInitialized();
    //firebase
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //env
    await dotenv.load(fileName: ".env");
    //services
    final socketClient = SocketClientImpl();
    socketClient.inicializeSocket();

    final apiConnectionManagerImpl = ApiConnectionManagerImpl(
      baseUrl: dotenv.env['API_URL']!,
    );

    final localNotifications = LocalNotificationsImpl(
        flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
        messaging: FirebaseMessaging.instance)
      ..inicializeLocalNotifications();

    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);

    // final firebaseToken = await localNotifications.getToken();
    // firebaseToken ??
    // final authToken = localStorage.getValue('appToken');

    final locationManager = LocationManagerImpl();
    //repositories
    final userRepository =
        UserRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final promotionalBannerRepository = PromotionalBannerRepositoryImpl(
        apiconnectionManager: apiConnectionManagerImpl);
    final playlistRepository =
        PlaylistRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final albumRepository =
        AlbumRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final artistRepository =
        ArtistRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final songRepository =
        SongRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);

    print(await localNotifications.getToken());
    // await localStorage.setKeyValue('appToken', '1');
    // await localStorage.setKeyValue('notificationsToken', '1');
    // await localStorage.setKeyValue('role', 'subscriber');
    //usecases
    final LogInUseCase logInUseCase = LogInUseCase(
        userRepository: userRepository,
        localStorage: localStorage,
        localNotifications: localNotifications);
    final SubscribeUseCase subscribeUseCase = SubscribeUseCase(
        userRepository: userRepository,
        localStorage: localStorage,
        localNotifications: localNotifications);
    final GetPromotionalBannerUseCase getPromotionalBannerUseCase =
        GetPromotionalBannerUseCase(
            promotionalBannerRepository: promotionalBannerRepository);
    final GetTrendingPlaylistsUseCase getTrendingPlaylistsUseCase =
        GetTrendingPlaylistsUseCase(playlistRepository: playlistRepository);
    final GetTrendingAlbumsUseCase getTrendingAlbumsUseCase =
        GetTrendingAlbumsUseCase(albumRepository: albumRepository);
    final GetTrendingArtistsUseCase getTrendingArtistsUseCase =
        GetTrendingArtistsUseCase(artistRepository: artistRepository);
    final GetTrendingSongsUseCase getTrendingSongsUseCase =
        GetTrendingSongsUseCase(songRepository: songRepository);
    final GetUserLocalDataUseCase getUserLocalDataUseCase =
        GetUserLocalDataUseCase(localStorage: localStorage);
    //blocs
    final getIt = GetIt.instance;

    getIt.registerSingleton<TrendingsBloc>(TrendingsBloc(
        getTrendingArtistsUseCase: getTrendingArtistsUseCase,
        getTrendingAlbumsUseCase: getTrendingAlbumsUseCase,
        getPromotionalBannerUseCase: getPromotionalBannerUseCase,
        getTrendingPlaylistsUseCase: getTrendingPlaylistsUseCase,
        getTrendingSongsUseCase: getTrendingSongsUseCase));
    getIt.registerSingleton<UserPermissionsBloc>(
        UserPermissionsBloc(getUserLocalDataUseCase: getUserLocalDataUseCase));
    getIt.registerSingleton<PlayerBloc>(PlayerBloc());
    getIt.registerSingleton<LogInSubscriberBloc>(LogInSubscriberBloc(
        logInUseCase: logInUseCase, subscribeUseCase: subscribeUseCase));
    //check if user has a session
    final userPermissionsBloc = getIt.get<UserPermissionsBloc>()
      ..add(UserPermissionsRequested());
    final connectionManager = ConnectionManagerImpl();
    getIt.registerSingleton<ConnectivityBloc>(
        ConnectivityBloc(connectionManager: connectionManager));
    getIt.registerSingleton<NotificationsBloc>(
        NotificationsBloc(localNotifications: localNotifications));
    getIt.registerSingleton<GpsBloc>(GpsBloc(
        locationManager: locationManager,
        userPermissionsBloc: userPermissionsBloc));

    final authGuard = AuthRouteGuard(userPermissionsBloc: userPermissionsBloc);
    final subscriptionGuard =
        SubscriptionRouteGuard(userPermissionsBloc: userPermissionsBloc);

    getIt.registerSingleton<AppNavigator>(AppNavigator(
        authRouteGuard: authGuard, subscriptionRouteGuard: subscriptionGuard));
  }
}
