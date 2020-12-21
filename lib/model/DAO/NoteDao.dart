import 'package:challenge/model/models/note.dart';
import 'package:floor/floor.dart';


@dao
abstract class NoteDao
{
  @Query("SELECT * FROM Note")
  Future<List<Note>> getallnoteasFuture();

  @Query("SELECT * FROM Note")
  Stream<List<Note>> getallnoteasStream();

  @Query("SELECT * FROM Note WHERE id = :id")
  Future<Note> getnote(int id);
  
  @insert
  Future<void> insertNote(Note note);

  @Query("DELETE FROM Note where id = :id")
  Future<void> deleteNote(int id);

  @update
  Future<int> updateNote(Note note); 
}