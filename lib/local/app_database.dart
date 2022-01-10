import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:visual_notes/local/item.dart';
import 'package:visual_notes/local/item_dao.dart';

import 'date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Item])
abstract class AppDatabase extends FloorDatabase {
  ItemDao get itemDao;
}
