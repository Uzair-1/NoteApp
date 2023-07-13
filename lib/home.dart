// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:internday1/screen4.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NotesApp/Notehome.dart';

class SharedPerference extends StatefulWidget {
  const SharedPerference({Key? key}) : super(key: key);

  @override
  State<SharedPerference> createState() => _SharedPerferenceState();
}

class _SharedPerferenceState extends State<SharedPerference> {
  String name='';
  String age='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title:Text("Shared Perferences"),),
      body: Column(
        children: [
          Text(name.toString()),
          Text(age.toString()),
          IconButton(onPressed: (){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => noteHomeScreen()),);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
         SharedPreferences Share =  await SharedPreferences.getInstance();
         // sp.setString('name', 'funzoft');
         // sp.setInt('age', 25);
         // sp.setBool('idea', true);
         // sp.remove('name');
         // sp.getString('name');
         // sp.getBool('idea');
         // sp.getInt('age');
         name = Share.getString('email')  ?? '';
         age = Share.getString('password') ?? '';
         setState(() {
         });
        },
      ),
    ));
  }
  // void logout() async {
  //   SharedPreferences share = await SharedPreferences.getInstance();
  //   await share.clear();
  //   Navigator.pushReplacement(
  //     context, MaterialPageRoute(builder: (context) => Login2()),
  //   );
  // }
}
