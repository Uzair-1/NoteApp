// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internday1/screen4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Loginpage.dart';
import 'NotesApp/Notehome.dart';
import 'home.dart';


void main() async{
  await Hive.initFlutter();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child:  noteHomeScreen(),
    );
  }
}

class Splach extends StatefulWidget {
  const Splach({Key? key}) : super(key: key);

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  String name= '';
  String age='@';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Login();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Icon(Icons.circle_outlined,size: 50,),
        ),
      )
    );
  }

  void Login()async{
     var share = await SharedPreferences.getInstance();
    name = share.getString('email') ?? '';
    age = share.getString('password') ?? '';
    print("object");
    Timer(Duration(seconds: 2), () {
      if(name.isNotEmpty && age.isNotEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SharedPerference()));
      }
     else if(age.isEmpty && name.isEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login2()));
      } else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login2()));
      }
    });

  }
}
