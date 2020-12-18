


import 'package:challenge/components/constants.dart';
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
                  return Card
                  (
                    semanticContainer: true,
                    borderOnForeground: true,
                    color: kMainColor,
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
                          Align
                          (
                            alignment: Alignment.bottomRight,
                            child: Text
                            (
                              "${DateFormat('yyyy-MM-dd HH:mm').format(snapshot.data[index].time)}"
                            ),
                          )
                        ],
                      )
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
      // height: this.widget.size.height ,
      // child: StreamBuilder<List<Note>>
      // (
      //   stream: this.widget.dao.getallnoteasStream(),
      //   builder: (context, snapshot) 
      //   {
      //     if(snapshot.hasData && snapshot.data.length >0)
      //     {
      //       return Container
      //       (
      //         width: this.widget.size.width - 5,
      //         height: this.widget.size.height * 0.25 -10,
      //         child: ListView.builder
      //         (
      //           physics: NeverScrollableScrollPhysics(),
      //           scrollDirection: Axis.vertical,
      //           padding: EdgeInsets.only
      //           (
      //             left: 5,
      //             right: 5
      //           ),
      //           itemCount: snapshot.data.length,
      //           itemBuilder: (context, index) 
      //           {
      //             return Card
      //             (
      //               semanticContainer: true,
      //               borderOnForeground: true,
      //               color: kMainColor,
      //               child: Container
      //               (
      //                 width: this.widget.size.width / 2 -10,
      //                 height: this.widget.size.height * 0.25 -10,
      //                 child: Text
      //                 (
      //                   "${snapshot.data[index].title}"
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       );
      //     }
      //     return Container
      //     (
      //       child: Center
      //       (
      //         child : Text
      //         (
      //           "Notthing to show"
      //         )
      //       ),
      //     );
      //   },
      // ),

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