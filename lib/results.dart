// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main.dart';

import 'package:flutter/material.dart';

import 'model/dog.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Dog>> dogs() async {
    // Get a reference to the database.
    final db = await openDatabase(
        join(await getDatabasesPath(), 'doggie_database.db'));

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
      
        future: dogs(),
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
              var a =snapshot.data;
              return Text("${snapshot.data[index].name}");
            });
          }
        },
      ),
    );
  }
}