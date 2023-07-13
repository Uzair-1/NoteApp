// ignore_for_file: unnecessary_import, prefer_const_constructors, non_constant_identifier_names, file_names, avoid_unnecessary_containers, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:internday1/screen4.dart';

class Login3 extends StatefulWidget {
  const Login3({Key? key}) : super(key: key);

  @override
  State<Login3> createState() => _Login3State();
}

class _Login3State extends State<Login3> {
  bool Ischeck =false;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool IsFinished = false;
  bool animated = false;
  // make a Hive database BOX (File which store the data of loginpage)
  late Box Boxdata;
  get buildContext => null;
  @override
  void initState() {
    super.initState();
    animatechange();
    CreateData();
  }
  void CreateData()async{
    Boxdata= await Hive.openBox('log');
    GetData();
  }
  // here we get the data which user enter it
  void GetData()async{
    if(Boxdata.get('email')!=null){
      email.text= Boxdata.get('email');
      Ischeck=true;
      setState(() {

      });
    }
    if(Boxdata.get('password')!=null){
      password.text=Boxdata.get('password');
      Ischeck=true;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('log in',style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.yellowAccent,
        actions: [
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
        child:ElevatedButton(child: Text("LOGIN INFO "),onPressed: (){
          _showMyDialog(buildContext,context);
        },),
        ),

        ],
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 2000),
            bottom: animated ? 0 : 60,
            right: animated ? 0 : 10,
            left: animated ? 0 : 10,
            top: animated ? 0 : 60,
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight:Radius.circular(40)),
                color: Colors.yellowAccent,
              ),
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 50, 20, 15),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Forget Password'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                          onPressed: (){
                            LoginData();
                          //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                          },
                          child: Text("LOGIN"),
                      )
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Terms and Conditions'),
                        ),
                        Checkbox(
                            value: Ischeck,
                            onChanged: (value){
                              Ischeck=!Ischeck;
                              setState(() {

                              });
                            }
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void LoginData() async {
    if (Ischeck) {
      Boxdata.put('email', email.text);
      Boxdata.put('password', password.text);
    }
  }
  // for deleting the data
  void delete ()async{
    if(Ischeck){
      Boxdata.delete('email');
      Boxdata.delete('password');
    }
  }

  Future animatechange() async { // for container
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      animated = true;
    });
 //  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  Future<void> _showMyDialog(buildContext, context) async {
    return showDialog(
        context: context,
        builder: (BuildContext  context){
          return AlertDialog(
            elevation: 0,
            title: Text(email.text.toString()),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(password.text.toString()),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                delete();
                Navigator.pop(context);
              }, child: Text("Delete")),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
            ],
          ) ;
        });
  }

}
