
import 'dart:async';
import 'package:challenge/model/DAO/NoteDao.dart';
import 'package:challenge/model/models/note.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite; 
import 'datetimeconvert.dart';

part 'databaseconnection.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Note])
abstract class NoteDB  extends FloorDatabase 
{
  NoteDao get noteDao;
}

  