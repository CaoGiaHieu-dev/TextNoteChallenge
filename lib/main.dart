

import 'package:challenge/controllers/databasehelper/databaseconnection.dart';
import 'package:challenge/model/DAO/NoteDao.dart';
import 'package:challenge/sceens/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'components/notification.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifyManager.init();
  final database = await $FloorNoteDB.databaseBuilder('database.db').build();
  final dao = database.noteDao ;

  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final NoteDao dao;
  
  const MyApp (this.dao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData
      (
        primarySwatch: Colors.blue,
      ),
      home: HomeSceens(dao:dao),
    );
  }
}
