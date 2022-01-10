import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:visual_notes/business_logic/item_bloc/items_bloc.dart';
import 'package:visual_notes/utils/app_routes.dart';
import 'package:visual_notes/utils/route_generator.dart';

import 'business_logic/bloc_observer.dart';
import 'dependencies/dependency_init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = getIt<AppBlocObserver>();
  Bloc.transformer = sequential<dynamic>();
  Logger.level = Level.debug;
  final itemsBloc = getIt<ItemsBloc>();
  runApp(MyApp(itemsBloc: itemsBloc));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.itemsBloc}) : super(key: key);
  final ItemsBloc itemsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => itemsBloc..add(ItemsFetched()),
      child: ScreenUtilInit(
          designSize: const Size(360.0, 730.0),
          builder: () {
            return MaterialApp(
              title: 'Visual Note',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: AppRoute.home,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }),
    );
  }
}
