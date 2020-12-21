


import 'package:challenge/components/constants.dart';
import 'package:challenge/components/notification.dart';
import 'package:challenge/model/models/note.dart';
import 'package:challenge/sceens/pages/note_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:challenge/model/DAO/NoteDao.dart';


class ListItems extends StatefulWidget 
{
  final Size size;

  final NoteDao dao ;
  ListItems
  (
    {
      Key key ,
      @required this.dao,
      @required this.size
    }
  ):super (key: key);
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> 
{
  @override
  Widget build(BuildContext context) 
  {
    return FittedBox
    (
      fit: BoxFit.contain,
      // height: this.widget.size.height -this.widget.size.height *0.25,
      // physics: NeverScrollableScrollPhysics(),
      child: FutureBuilder
      (
        future: this.widget.dao.getallnoteasFuture(),
        builder: (context, snapshot) 
        {
          if(snapshot.hasData && snapshot.data.length >0)
          {
            return Container
            (
              width: this.widget.size.width - 5,
              // height: this.widget.size.height * 0.5 - 10,
              child: ListView.builder
              (
                shrinkWrap: true, 
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only
                (
                  left: 5,
                  right: 5
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) 
                {
                  return Slidable
                  (
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>
                    [
                      IconSlideAction
                      (
                        caption: snapshot.data[index].active == 1 ? "Deactive" :'Active',
                        color: kButtonColor,
                        icon: snapshot.data[index].active == 1? Icons.notifications_off : Icons.notifications_active,
                        onTap: () 
                        {
                          setState(() 
                          {
                            this.widget.dao.updateNote
                            (
                              Note
                              (
                                snapshot.data[index].id,
                                snapshot.data[index].title,
                                snapshot.data[index].body,
                                snapshot.data[index].time,
                                snapshot.data[index].active == 1 ? 0 : 1,
                                 snapshot.data[index].type
                              )
                            );
                            snapshot.data[index].active == 1
                            ? localNotifyManager.cancelNotification(snapshot.data[index].id)
                            : localNotifyManager.dailyNotification(snapshot.data[index].time,snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].body);
                            
                          });
                        },
                      ),
                      IconSlideAction
                      (
                        caption: 'Remove',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () 
                        {
                          setState(() 
                          {
                            this.widget.dao.deleteNote(snapshot.data[index].id);
                            localNotifyManager.cancelNotification(snapshot.data[index].id);
                          });
                        },
                      ),
                    ],
                    child: GestureDetector
                    (
                      onTap: () 
                      {
                        Navigator.push
                        (
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) =>NoteScreen
                            (
                              dao : this.widget.dao,
                              oldvalues : snapshot.data[index],
                            ) 
                          )
                        ).whenComplete(() 
                        {
                          setState(() 
                          {
                            
                          });
                        });
                      },
                      child: Card
                      (
                        semanticContainer: true,
                        borderOnForeground: true,
                        color: snapshot.data[index].active ==1 ? kMainColor :kDefault,
                        child: Container
                        (
                          width: this.widget.size.width / 2 -10,
                          height: this.widget.size.height * 0.1 ,
                          child: Column
                          (
                            children: <Widget>
                            [
                              Text
                              (
                                "${snapshot.data[index].title}"
                              ),
                              Spacer(),
                              Text
                              (
                                "${snapshot.data[index].body}"
                              ),
                              Spacer(),
                              Row
                              (
                                children: <Widget>
                                [
                                  Align
                                  (
                                    alignment: Alignment.bottomRight,
                                    child: Text
                                    (
                                      "${DateFormat('yyyy-MM-dd HH:mm').format(snapshot.data[index].time)}"
                                    ),
                                  ),
                                  Spacer(),
                                  Align
                                  (
                                    alignment: Alignment.bottomLeft,
                                    child: Text
                                    (
                                      (snapshot.data[index].type)==1 ? "At Time" : "Daily"
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  );
                },
              )
            );
          }
          return Container
          (
            child: Center
            (
              child : Text
              (
                "Notthing to show"
              )
            ),
          );
        },
      )
    );
  }
}