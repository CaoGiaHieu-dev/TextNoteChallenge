//property
import 'package:flutter/material.dart';

class DateTimePicker
{
  DateTime datetime;
  DateTime date;
  TimeOfDay time;
  DateTimePicker.init()
  {
    datetime = DateTime.now();
  }
  //date picker
  selectDate(BuildContext context) async 
  {
    final DateTime datePicker = await showDatePicker
    (
      context: context,
      initialDate: datetime,
      firstDate: DateTime(datetime.year),
      lastDate: DateTime(5000),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    if (datePicker != null && datePicker != datetime)
    {
      date = datePicker;
    }
  }
  //time picker
  selectedTime(BuildContext context) async
  {
    final TimeOfDay timePicker = await showTimePicker
    (
      context: context,
      initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute),
      builder: (BuildContext context, Widget child) 
      {
        return MediaQuery
        (
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if(timePicker !=null )
    {
      time = timePicker;
    }
  }
}

DateTimePicker dateTimePicker = DateTimePicker.init();