import 'package:injectable/injectable.dart';
import 'package:visual_notes/local/app_database.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  @preResolve
  Future<AppDatabase> get appDatabase =>
      $FloorAppDatabase.databaseBuilder('test.db').build();
}
