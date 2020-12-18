 import 'package:challenge/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeList extends StatefulWidget 
{
  final Size size;

  SwipeList
  (
    {
      Key key ,
      @required this.size
    }
  ):super (key: key);
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<SwipeList> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      height: this.widget.size.height *0.25 - 10,
      child: ListView.builder
      (
        scrollDirection: Axis.horizontal,
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
              child: Text
              (
                "$index"
              ),
            ),
          );
        },
      ),
    );
  }
}