// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseconnection.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorNoteDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDBBuilder databaseBuilder(String name) => _$NoteDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDBBuilder inMemoryDatabaseBuilder() => _$NoteDBBuilder(null);
}

class _$NoteDBBuilder {
  _$NoteDBBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$NoteDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NoteDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NoteDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$NoteDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NoteDB extends NoteDB {
  _$NoteDB([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `body` TEXT, `time` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'time': _dateTimeConverter.encode(item.time)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  @override
  Stream<List<Note>> getallnote() {
    return _queryAdapter.queryListStream('SELECT * FROM Note',
        queryableName: 'Note',
        isView: false,
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['title'] as String,
            row['body'] as String,
            _dateTimeConverter.decode(row['time'] as int)));
  }

  @override
  Stream<List<Note>> getallnoteasStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Note',
        queryableName: 'Note',
        isView: false,
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['title'] as String,
            row['body'] as String,
            _dateTimeConverter.decode(row['time'] as int)));
  }

  @override
  Future<Note> getnote(int id) async {
    return _queryAdapter.query('SELECT * FROM Note WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Note(
            row['id'] as int,
            row['title'] as String,
            row['body'] as String,
            _dateTimeConverter.decode(row['time'] as int)));
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
