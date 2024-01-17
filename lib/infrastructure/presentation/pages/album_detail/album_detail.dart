// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/use_cases/album/get_album_data_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/image_cover.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/shared/info.dart';
import '../../../../application/BLoC/album_detail/album_detail_bloc.dart';
import '../../widgets/shared/tracklist.dart';

class AlbumDetail extends IPage {
  final String albumId;
  late final AlbumDetailBloc albumBloc;

  AlbumDetail({super.key, required this.albumId}) {
    albumBloc = AlbumDetailBloc(
        getAlbumDataUseCase: GetIt.instance.get<GetAlbumDataUseCase>());
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(create: (context) {
      albumBloc.add(FetchAlbumDetailEvent(albumId: albumId));
      return albumBloc;
    }, child: BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
      builder: (context, albumState) {
        final size = MediaQuery.of(context).size;

        if (albumState is AlbumDetailLoaded) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ImageCover(
                        image: albumState.album.image,
                        height: size.width * 0.6,
                        width: size.width * 0.6,
                        bottomPadding: 40),
                    Info(
                      name: albumState.album.name!,
                      artistName: albumState.album.artistName,
                      songs: albumState.album.songs!,
                      duration: albumState.album.duration!,
                    ),
                    //TODO: Wave  ()
                    const SizedBox(height: 30),
                    Tracklist(songs: albumState.album.songs!),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          );
        } else if (albumState is AlbumDetailFailed) {
          return ErrorPage(failure: albumState.failure);
        } else {
          return const CustomCircularProgressIndicator();
        }
      },
    ));
  }
}
