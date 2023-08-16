
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: Firebase_CRUD(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
    )
  );
}