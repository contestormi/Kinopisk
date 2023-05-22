import 'package:kinopoisk/services/directory_service.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryServiceImpl implements DirectoryService {
  @override
  Future<String> getTempPath() async {
    return (await getTemporaryDirectory()).path;
  }
}
