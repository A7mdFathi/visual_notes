// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../business_logic/bloc_observer.dart' as _i7;
import '../business_logic/item_bloc/items_bloc.dart' as _i6;
import '../local/app_database.dart' as _i3;
import '../repositories/image_repository.dart' as _i5;
import '../utils/app_logger.dart' as _i4;
import 'register_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.AppDatabase>(() => registerModule.appDatabase,
      preResolve: true);
  gh.singleton<_i4.AppLogger>(_i4.AppLogger());
  gh.factory<_i5.ImageRepository>(() => _i5.ImageRepository());
  gh.factory<_i6.ItemsBloc>(
      () => _i6.ItemsBloc(get<_i3.AppDatabase>(), get<_i4.AppLogger>()));
  gh.factory<_i7.AppBlocObserver>(
      () => _i7.AppBlocObserver(get<_i4.AppLogger>()));
  return get;
}

class _$RegisterModule extends _i8.RegisterModule {}
