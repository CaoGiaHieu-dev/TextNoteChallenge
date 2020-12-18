
import 'package:floor/floor.dart';

 @entity
 class Note 
 {
    @PrimaryKey(autoGenerate: true)
    final int id;

    final String title;

    final String body;

    final DateTime time;
    

    Note
    (
      this.id, 
      this.title,
      this.body,
      this.time
    );

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is Note &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title &&
            body == other.body &&
            time == other.time;

    @override
    int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode ^ time.hashCode ;

    @override
    String toString() 
    {
      return 'Task{id: $id, title: $title ,body : $body , time:$time}';
    }
 }  