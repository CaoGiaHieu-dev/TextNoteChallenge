
import 'package:floor/floor.dart';

 @entity
 class Note 
 {
    @PrimaryKey(autoGenerate: true)
    final int id;

    final String title;

    final String body;

    final DateTime time;
    
    final int active ;
    Note
    (
      this.id, 
      this.title,
      this.body,
      this.time,
      this.active
    );

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is Note &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title &&
            body == other.body &&
            time == other.time &&
            active == other.active;

    @override
    int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode ^ time.hashCode ^ active.hashCode ;

    @override
    String toString() 
    {
      return 'Task{id: $id, title: $title ,body : $body , time:$time , active:$active}';
    }
 }  