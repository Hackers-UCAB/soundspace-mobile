import '../../../common/result.dart';
import '../song.dart';

abstract class SongRepository {
  Future<Result<List<Song>>> getSongs();
}
