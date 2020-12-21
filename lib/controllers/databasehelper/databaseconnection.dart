
import 'dart:async';
import 'package:challenge/model/DAO/NoteDao.dart';
import 'package:challenge/model/models/note.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite; 
import 'datetimeconvert.dart';

part 'databaseconnection.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 3, entities: [Note], views:[Note])
abstract class NoteDB  extends FloorDatabase 
{
  NoteDao get noteDao;
}

// create migration
final migration1to2 = Migration(2, 3, (database) async 
{
  database.execute('ALTER TABLE Note ADD COLUMN type INT');
});
  