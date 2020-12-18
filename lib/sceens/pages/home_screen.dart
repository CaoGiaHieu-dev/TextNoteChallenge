
import 'package:challenge/components/constants.dart';
import 'package:challenge/components/notification.dart';
import 'package:challenge/model/DAO/NoteDao.dart';
import 'package:challenge/model/models/note.dart';
import 'package:challenge/sceens/pages/note_screen.dart';
import 'package:challenge/sceens/widgets/header.dart';
import 'package:challenge/sceens/widgets/listItems.dart';
import 'package:challenge/sceens/widgets/swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSceens extends StatefulWidget 
{
  final NoteDao dao ; 
  HomeSceens
  (
    {
      Key key,
      @required this.dao
    }
  ) : super(key: key);
  @override
  _HomeSceensState createState() => _HomeSceensState();
}

class _HomeSceensState extends State<HomeSceens> 
{
  Future<List<Note>> noteList ;

  @override
  void initState() 
  {
    
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);

  }

  onNotificationReceive(RecetiveNotification notification) 
  {
    print("Notification Receive : ${notification.id}");
  }

  onNotificationClick(String payload)
  {
    print("Payload : $payload");
  }

  
  @override
  Widget build(BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      // appBar: AppBar
      // (
      //   backgroundColor: kBackGroundColor,
      // ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: ()
        {
          Navigator.push
          (
            context, 
            MaterialPageRoute
            (
              builder: (context) =>NoteScreen
              (
                dao : this.widget.dao
              ) 
            )
          ).whenComplete(() 
          {
            setState(() {
              
            });
          });
          // dateTimePicker.selectDate(context);
          // await _selectedTime(context);
          // await _selectDate(context);
          // await localNotifyManager.showNotification();
          // await localNotifyManager.schedulesNotification();
          // await localNotifyManager.repeatNotification();
        },
        backgroundColor: kButtonColor,
        child: Icon
        (
          Icons.add
        ),
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [   
            Header
            (
              size : size
            ),
            SizedBox
            (
              height: 5,
            ),
            SwipeList
            (
              size :size
            ),
            SizedBox
            (
              height: 5,
            ),
            ListItems
            (
              size: size,
              dao : this.widget.dao
            )
          ],
        ),
      ),
    );
  }
}

