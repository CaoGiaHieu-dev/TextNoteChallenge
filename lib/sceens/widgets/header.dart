import 'package:challenge/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatefulWidget 
{
  final Size size;

  Header
  (
    {
       Key key ,
      @required this.size
    }
  ) : super (key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      padding: EdgeInsets.only
      (
        top: 25
      ),
      height: this.widget.size.height * 0.25 ,
      decoration: BoxDecoration
      (
        color: kMainColor,
        borderRadius: BorderRadius.only
        (
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)
        ),
      ),
      child: Row
      (
        children: <Widget>
        [
          SizedBox
          (
            width: 10,
          ),
          // Title 
          Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> 
            [
              Text
              (
                "Anflash",
                style: TextStyle
                (
                  color: kTextColor,
                  fontSize: 25,
                ),
              ),
              Text
              (
                "Technology Company",
                style: TextStyle
                (
                  color: Colors.black,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Spacer(),
          SvgPicture.asset
          (
            "assets/images/logo-full.svg",
            height: 50,
          ),
        ],
      )
    );
  }
}