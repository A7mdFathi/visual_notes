// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDao? _itemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Item` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `img` TEXT NOT NULL, `description` TEXT NOT NULL, `dateTime` INTEGER NOT NULL, `status` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _itemInsertionAdapter = InsertionAdapter(
            database,
            'Item',
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'img': item.img,
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'status': item.status ? 1 : 0
                },
            changeListener),
        _itemUpdateAdapter = UpdateAdapter(
            database,
            'Item',
            ['id'],
            (Item item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'img': item.img,
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'status': item.status ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Item> _itemInsertionAdapter;

  final UpdateAdapter<Item> _itemUpdateAdapter;

  @override
  Future<List<Item>> findAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM Item',
        mapper: (Map<String, Object?> row) => Item(
            id: row['id'] as int,
            title: row['title'] as String,
            img: row['img'] as String,
            description: row['description'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            status: (row['status'] as int) != 0));
  }

  @override
  Stream<Item?> findItemById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Item WHERE id= ?1',
        mapper: (Map<String, Object?> row) => Item(
            id: row['id'] as int,
            title: row['title'] as String,
            img: row['img'] as String,
            description: row['description'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            status: (row['status'] as int) != 0),
        arguments: [id],
        queryableName: 'Item',
        isView: false);
  }

  @override
  Future<void> deleteItem(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Item WHERE id= ?1', arguments: [id]);
  }

  @override
  Future<void> insertItem(Item item) async {
    await _itemInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Item item) {
    return _itemUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
