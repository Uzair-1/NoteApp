// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, use_build_context_synchronously, must_call_super

import 'package:flutter/material.dart';
import 'package:internday1/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login2 extends StatefulWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  String name= '';
  String age='';
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  bool _passwordVisibility=false;
   @override
  void initState() {
     Login();
    _passwordVisibility=false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Shared Perferences'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name.toString()),
              Text(age.toString()),
              SizedBox(height: 10,),
             Padding(padding: EdgeInsets.fromLTRB(20, 50, 20, 15),
             child:  TextFormField(
               controller: email,
               decoration: InputDecoration(
                   hintText: 'Email',
                   suffixIcon: Icon(Icons.email_outlined),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20),
                   )
               ),
             ),
             ),
              Padding(padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                child:  TextFormField(
                  controller: password,
                  obscureText: _passwordVisibility,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                      icon: Icon(_passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,),
                        onPressed: (){
                          setState(() {
                            _passwordVisibility =!_passwordVisibility;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () async{
                  SharedPreferences share =  await SharedPreferences.getInstance();
                  share.setString('email', email.text.toString());
                  share.setString('password', password.text.toString());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SharedPerference()));
                  Login();
                },
                child: Text("Log in"),
              )

            ],
          ),
        ),
      )
    ));
  }
  void Login()async{
    var Share =  await SharedPreferences.getInstance();
   name = Share.getString('email')  ?? '';
   age = Share.getString('password') ?? '';
   //print("object");

  }
}
































// // ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_import, avoid_unnecessary_containers, unused_import, prefer_const_literals_to_create_immutables
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
// import 'Loginpage.dart';
//
// class SignupPage extends StatefulWidget {
//   const SignupPage({Key? key}) : super(key: key);
//
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   TextEditingController name=TextEditingController();
//   TextEditingController phone=TextEditingController();
//   // TextEditingController confirmpassword=TextEditingController();
//
//   bool Ischecked=false;
//   bool IsFinished = false;
//   bool animated = false;
//   get buildContext => null;
//   // make the Hive Box for the SignUp data
//
//
//   @override
//   void initState() {
//     super.initState();
//     animatechange();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Sign Up',style: TextStyle(color: Colors.black),),
//         elevation: 0,
//         backgroundColor: Colors.yellowAccent,
//         actions: [
//          Padding(padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
//          child: ElevatedButton(child: Text("SIGNUP INFO "),
//            onPressed: (){
//            _showMyDialog(buildContext,context);
//          },),
//          )
//         ],
//       ),
//       body: Stack(
//         children: [
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 2000),
//             bottom: animated ? 0 : 60,
//             right: animated ? 0 : 10,
//             left: animated ? 0 : 10,
//             top: animated ? 0 : 60,
//             child: Container(
//               decoration: BoxDecoration(
//                 // borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight:Radius.circular(40)),
//                 color: Colors.yellowAccent,
//               ),
//               height: 100,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 50, 20, 15),
//                     child: TextFormField(
//                       controller: name,
//                       decoration: InputDecoration(
//                         filled: true,
//                         hintText: 'Name',
//                         prefixIcon: Icon(Icons.person_outline_outlined),
//                         suffixIcon: Icon(Icons.password),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     child: TextFormField(
//                       controller: phone,
//                       decoration: InputDecoration(
//                         filled: true,
//                         hintText: 'Phone Number',
//                         prefixIcon: Icon(Icons.mobile_screen_share),
//                         suffixIcon: Icon(Icons.remove_red_eye_outlined),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     child: TextFormField(
//                      // controller: confirmpassword,
//                       decoration: InputDecoration(
//                         filled: true,
//                         hintText: 'Confirm Password',
//                         prefixIcon: Icon(Icons.lock_open_outlined),
//                         suffixIcon: Icon(Icons.remove_red_eye_outlined),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                        Checkbox(
//                            value: Ischecked,
//                            onChanged: (value){
//                              Ischecked=!Ischecked;
//                              setState(() {
//
//                              });
//                            }
//                        ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: ElevatedButton(onPressed: (){
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
//                     }, child: Text('Sig Up')),
//                   ),
//                   SizedBox(height: 15,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextButton(
//                           onPressed: () {},
//                           child: Text('Already a member? LOG IN'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Future<void> _showMyDialog(buildContext, context) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext  context){
//           return AlertDialog(
//             elevation: 0,
//           //  title: Text(email.text.toString()),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: [
//                   //Text(password.text.toString()),
//                 ],
//               ),
//             ),
//             actions: [
//              // TextButton(onPressed: (){}, child: Text("Start")),
//               TextButton(onPressed: (){
//                 Navigator.pop(context);
//               }, child: Text("Cancel")),
//             ],
//           ) ;
//         });
//   }
//    // For addeding and store the data
//
//   Future animatechange() async {
//     await Future.delayed(Duration(milliseconds: 2000));
//     setState(() {
//       animated = true;
//     });
//   }
// }
