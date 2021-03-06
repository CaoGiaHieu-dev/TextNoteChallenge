import 'package:challenge/components/constants.dart';
import 'package:challenge/components/datetimepicker.dart';
import 'package:challenge/model/DAO/NoteDao.dart';
import 'package:challenge/model/models/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatefulWidget
{
  final NoteDao dao ;
  final Note oldvalues;
  NoteScreen
  (
    {
      Key key,
      @required this.dao,
      this.oldvalues,
    }
  ): super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> 
{
  //property
  bool _validateTitle ;
  bool _validatetime ;
  bool _updated;
  bool _validateDate ;
  String _title ;
  String _body ;
  Type _type = Type.daily;
  @override
  void initState() 
  {
    DateTimePicker.init();
    dateTimePicker.time=null;
    dateTimePicker.date=null;

    _updated = false;

    //init validate
    _validateTitle=false;
    _validatetime=false;
    _validateDate=false;

    _title==null ?_title ="" : _title = _title;
    _body==null ? _body ="" : _body = _body;

    if(this.widget.oldvalues != null)
    {
      _title = this.widget.oldvalues.title;
      _body = this.widget.oldvalues.body;
      dateTimePicker.date = this.widget.oldvalues.time;
      dateTimePicker.time = TimeOfDay(hour:this.widget.oldvalues.time.hour  , minute: this.widget.oldvalues.time.minute );
      _updated=true;
      this.widget.oldvalues.type == 1 ?_type = Type.attime : _type = Type.daily;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      backgroundColor: kBackGroundColor,
      appBar: AppBar
      (
        backgroundColor: kBackGroundColor,
        actions: 
        [
          GestureDetector
          (
            onTap: () async
            {
              if(_title!= null && _title != "" && dateTimePicker.time!=null && dateTimePicker.date!=null)
              {
                //insert new note
                _updated == true
                ? await this.widget.dao.updateNote
                (
                  Note
                  (
                    this.widget.oldvalues.id, //id
                    _title, //title
                    _body , //body
                    dateTimePicker.date.add(Duration(hours:dateTimePicker.time.hour,minutes: dateTimePicker.time.minute)) , //datetime
                    0,//active
                    _type.index 
                  )
                )
                : await this.widget.dao.insertNote
                (
                  Note
                  (
                    null, //id
                    _title, //title
                    _body , //body
                    dateTimePicker.date.add(Duration(hours:dateTimePicker.time.hour,minutes: dateTimePicker.time.minute)) , //datetime
                    0, //active
                    _type.index 
                  )
                );
                Navigator.of(context).pop();
              } 
              else
              {
                setState(() 
                {
                  if(_title== null || _title == "")
                  {
                    _validateTitle=true;
                  }
                  else
                  {
                    _validateTitle=false;
                  }
                  if(dateTimePicker.time==null)
                  {
                    _validatetime=true;
                  }
                  else
                  {
                    _validatetime=false;
                  }
                  if(dateTimePicker.date==null)
                  {
                    _validateDate=true;
                  }
                  else
                  {
                    _validateDate=false;
                  }
                });
              } 
            },
            child: Icon
            (
              Icons.done_all_outlined,
              color: kButtonColor,
            ),
          )
        ],
        leading: GestureDetector
        (
          onTap: () => Navigator.of(context).pop(),
          child: Icon
          (
            Icons.cancel_presentation_outlined,
            color: kButtonColor,
          ),
        ),
        title: Text
        (
          "New Note",
          style: TextStyle
          (
            color: kMainColor
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector
      (
        behavior: HitTestBehavior.opaque,
        onTap: () 
        {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView
        (
          physics: NeverScrollableScrollPhysics(),
          child: Container
          (
            height: size.height-20,
            width: size.width,
            alignment: Alignment.center,
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>
              [
                //Title
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Container
                    (
                      width: size.width -10,
                      alignment: Alignment.center,
                      child: TextField
                      (
                        keyboardType: TextInputType.text ,
                        textAlign: TextAlign.center,
                        controller: TextEditingController
                        (
                          text: _title
                        ),
                        decoration: InputDecoration
                        (
                          errorText: _validateTitle ? "Title can't be empty" : null,
                          hintText: "Title",
                          border: OutlineInputBorder
                          (
                            borderSide: BorderSide
                            (
                              color: kMainColor,
                            )
                          )
                        ),
                        onChanged: (text)
                        {
                          if(text.isEmpty)
                          {
                            _validateTitle = true;
                            _title="";
                          }
                          else
                          {
                            _title=text;
                          }
                        },
                      )
                    )
                  ],
                ),
                SizedBox
                (
                  height: 50,
                ),
                // body text
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Container
                    (
                      width:size.width -10 ,
                      alignment: Alignment.center,
                      child: SingleChildScrollView
                      (
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: TextField
                        (
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline ,
                          minLines: 20,//Normal textInputField will be displayed
                          maxLines: 20,// when user presses enter it will adapt to it
                          textAlign: TextAlign.center,
                          controller: TextEditingController
                          (
                            text: _body
                          ),
                          decoration: InputDecoration
                          (
                            //errorText: _validateUserName ? "User name can't be empty" : null,
                            hintText: "Body",
                            border: OutlineInputBorder
                            (
                              borderSide: BorderSide
                              (
                                color: kMainColor,
                              )
                            )
                          ),
                          onChanged: (text)
                          {
                            if(text.isEmpty)
                            {
                              _body ="";
                            }
                            else
                            {
                              _body=text;
                            }
                          },
                        ),
                      )
                    )
                  ],
                ),

                //selceted datetime
                SizedBox
                (
                  height: 10,
                ),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Container
                    (
                      width: size.width /2 -20,
                      child: ListTile
                      (
                        title: Text('Daily'),
                        leading: Radio
                        (
                          value: Type.daily,
                          groupValue: _type,
                          onChanged: (Type value) 
                          {
                            setState(() 
                            {
                              _type = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container
                    (
                      width: size.width /2 -20,
                      child: ListTile
                      (
                        title: Text('At Time'),
                        leading: Radio
                        (
                          value: Type.attime,
                          groupValue: _type,
                          onChanged: (Type value) 
                          {
                            setState(() 
                            {
                              _type = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //selceted datetime
                SizedBox
                (
                  height: 10,
                ),
                _type.index == 1
                ? Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    //date
                    Container
                    (
                      width: size.width /2 -20,
                      alignment: Alignment.center,
                      child: TextField
                      (
                        onTap:() 
                        {
                          showDatePicker
                          (
                            context: context,
                            initialDate: dateTimePicker.datetime,
                            firstDate: DateTime(dateTimePicker.datetime.year),
                            lastDate: DateTime(5000),
                            errorFormatText: 'Enter valid date',
                            errorInvalidText: 'Enter date in valid range',
                          ).then((DateTime value)  
                          { 
                            if (value != null && value != dateTimePicker.datetime)
                            {
                              setState(() 
                              {
                                dateTimePicker.date = value;
                                _validateDate = false;
                              });
                            }
                          });
                          
                        },
                        readOnly: true,
                        keyboardType: TextInputType.text ,
                        textAlign: TextAlign.center,
                        controller: TextEditingController
                        (
                          text: dateTimePicker.date==null 
                          ? "Selected Date"
                          : DateFormat('yyyy-MM-dd').format(dateTimePicker.date)
                        ),
                        decoration: InputDecoration
                        (
                           errorText: _validateDate? "Date have to be selected" : null,
                          border: OutlineInputBorder
                          (
                            borderSide: BorderSide
                            (
                              color: kMainColor,
                            )
                          )
                        ),
                        onChanged: (text)
                        {
                          if(text.isEmpty || dateTimePicker.date==null )
                          {
                            _validateDate = true;
                            dateTimePicker.date=null;
                          }
                        },
                      )
                    ),
                    Spacer(),
                    //time
                    Container
                    (
                      width: size.width /2 -20,
                      alignment: Alignment.center,
                      child: TextField
                      (
                        onTap:() 
                        {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showTimePicker
                          (
                            context: context,
                            initialTime: TimeOfDay(hour: dateTimePicker.datetime.hour, minute: dateTimePicker.datetime.minute),
                            builder: (BuildContext context, Widget child) 
                            {
                              return MediaQuery
                              (
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                child: child,
                              );
                            },
                          ).then((value)
                          {
                            if(value !=null )
                            {
                              setState(() 
                              {
                                dateTimePicker.time = value;
                                _validatetime = false;
                              });
                            }
                          });
                        },
                        readOnly: true,
                        keyboardType: TextInputType.text ,
                        textAlign: TextAlign.center,
                        controller: TextEditingController
                        (
                          text: dateTimePicker.time==null 
                          ? "Selected time"
                          : "${dateTimePicker.time.hour} : ${dateTimePicker.time.minute}"
                          // : DateFormat('yyyy-MM-dd').format(dateTimePicker.time)
                        ),
                        decoration: InputDecoration
                        (
                          errorText: _validatetime ? "Time have to be selected" : null,
                          border: OutlineInputBorder
                          (
                            borderSide: BorderSide
                            (
                              color: kMainColor,
                            )
                          )
                        ),
                        onChanged: (text)
                        {
                          if(text.isEmpty || dateTimePicker.time==null )
                          {
                            _validatetime = true;
                            dateTimePicker.time=null;
                          }
                        },
                      )
                    )
                  
                  ],
                )
                : Container
                (
                  width: size.width /2 -20,
                  alignment: Alignment.center,
                  child: TextField
                  (
                    onTap:() 
                    {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      showTimePicker
                      (
                        context: context,
                        initialTime: TimeOfDay(hour: dateTimePicker.datetime.hour, minute: dateTimePicker.datetime.minute),
                        builder: (BuildContext context, Widget child) 
                        {
                          return MediaQuery
                          (
                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                            child: child,
                          );
                        },
                      ).then((value)
                      {
                        if(value !=null )
                        {
                          setState(() 
                          {
                            DateTime now = new DateTime.now();
                            dateTimePicker.date = new DateTime(now.year , now.month , now.day);
                            dateTimePicker.time = value;
                            _validatetime = false;
                            _validateDate = false;

                          });
                        }
                      });
                    },
                    readOnly: true,
                    keyboardType: TextInputType.text ,
                    textAlign: TextAlign.center,
                    controller: TextEditingController
                    (
                      text: dateTimePicker.time==null 
                      ? "Selected time"
                      : "${dateTimePicker.time.hour} : ${dateTimePicker.time.minute}"
                      // : DateFormat('yyyy-MM-dd').format(dateTimePicker.time)
                    ),
                    decoration: InputDecoration
                    (
                      errorText: _validatetime ? "Time have to be selected" : null,
                      border: OutlineInputBorder
                      (
                        borderSide: BorderSide
                        (
                          color: kMainColor,
                        )
                      )
                    ),
                    onChanged: (text)
                    {
                      if(text.isEmpty || dateTimePicker.time==null )
                      {
                        _validatetime = true;
                        _validateDate =true;
                        dateTimePicker.time=null;
                      }
                    },
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}