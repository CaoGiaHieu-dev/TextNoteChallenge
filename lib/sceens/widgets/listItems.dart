


import 'package:challenge/components/constants.dart';
import 'package:challenge/model/models/note.dart';
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
    return Container
    (
      height: this.widget.size.height ,
      child: StreamBuilder<List<Note>>
      (
        stream: this.widget.dao.getallnoteasStream(),
        builder: (context, snapshot) 
        {
          if(snapshot.hasData && snapshot.data.length >0)
          {
            return ListView.builder
            (
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only
              (
                left: 5,
                right: 5
              ),
              itemCount: 10,
              itemBuilder: (context, index) 
              {
                return Card
                (
                  semanticContainer: true,
                  borderOnForeground: true,
                  color: kMainColor,
                  child: Container
                  (
                    width: this.widget.size.width / 2 -10,
                    height: this.widget.size.height * 0.25 -10,
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      // child: ListView.builder
      // (
      //   physics: NeverScrollableScrollPhysics(),
      //   scrollDirection: Axis.vertical,
      //   padding: EdgeInsets.only
      //   (
      //     left: 5,
      //     right: 5
      //   ),
      //   itemCount: 10,
      //   itemBuilder: (context, index) 
      //   {
      //     return Card
      //     (
      //       semanticContainer: true,
      //       borderOnForeground: true,
      //       color: kMainColor,
      //       child: Container
      //       (
      //         width: this.widget.size.width / 2 -10,
      //         height: this.widget.size.height * 0.25 -10,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}