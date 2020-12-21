
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

    final int type ;
    Note
    (
      this.id, 
      this.title,
      this.body,
      this.time,
      this.active,
      this.type
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
            active == other.active &&
            type == other.type;

    @override
    int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode ^ time.hashCode ^ active.hashCode ^type.hashCode ;

    @override
    String toString() 
    {
      return 'Task{id: $id, title: $title ,body : $body , time:$time , active:$active ,type:$type}';
    }
 }  