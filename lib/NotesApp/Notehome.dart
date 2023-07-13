// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, avoid_print, file_names, must_call_super, sort_child_properties_last, avoid_web_libraries_in_flutter, use_build_context_synchronously, unused_import, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:internday1/NotesApp/datamodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen4.dart';

class noteHomeScreen extends StatefulWidget {
  const noteHomeScreen({Key? key}) : super(key: key);

  @override
  State<noteHomeScreen> createState() => _noteHomeScreenState();
}

class _noteHomeScreenState extends State<noteHomeScreen> {
  List<Notes> NoteList=[];
  TextEditingController title =TextEditingController();
  TextEditingController description =TextEditingController();
  @override
  void initState() {
    NoteData();
  }
  void NoteData()async{
    SharedPreferences data = await SharedPreferences.getInstance();
  final title= data.getString('title');
  final description= data.getString('description');
  if(title!=null&& description!=null){
    final newnote= Notes(title: title, description: description);
    setState(() {
      NoteList.add(newnote);
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes App'),
          leading:  Padding(padding: EdgeInsets.fromLTRB(0, 0, 10,0),
            child: Icon(Icons.account_circle_outlined),
          ),
          centerTitle: true,
          shadowColor: Colors.teal,
          titleSpacing: 10,
          actions: [
           GestureDetector(
             onTap: () async{
               _LogoutDialog ();
             },
             child:  Padding(padding: EdgeInsets.fromLTRB(0, 0, 10,0),
               child: Icon(Icons.logout_outlined),
             ),
           )
          ],
        ),
        body: ListView.builder(
            itemCount: NoteList.length,
            itemBuilder: (context,index){
              return SingleChildScrollView(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child:Container(
                            child:Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("TITLE",style: TextStyle(color: Colors.brown.shade200,fontSize: 17),),
                                    Spacer(),
                                    GestureDetector(onTap: (){
                                      deleteNote(index);
                                    },
                                      child: Icon(Icons.delete,color: Colors.redAccent.shade400,),
                                    ),
                                    SizedBox(width: 20,),
                                    GestureDetector(onTap: (){
                                      editNote(index);
                                    },
                                      child: Icon(Icons.edit,color: Colors.blueGrey.shade300,),
                                    ),
                                  ],
                                ),
                                  Text(NoteList[index].title.toString()),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text("DESCRIPTION",style: TextStyle(color: Colors.brown.shade200,fontSize: 17),),
                                     ],
                                   ),
                                  Text(NoteList[index].description.toString()),
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
         _showMyDialog();
            print("object");
          },
          child: Icon(Icons.add_circle_outline),
          backgroundColor: Colors.blueGrey,
      ),
    ));
  }
  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          title: Text('Add Notes Here',
            style: TextStyle(fontSize: 20),),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    suffixIcon: Icon(Icons.title),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Descriptions',
                    suffixIcon: Icon(Icons.description),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Addnote();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  Future<void> _LogoutDialog () async {
    return showDialog(
        context: context,
        builder: (BuildContext  context){
          return AlertDialog(
            elevation: 0,
            title: Icon(Icons.error_outline_outlined),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Are you Sure to logout'),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                logout();
              }, child: Text('Sure'),
              )],
          ) ;
        });
  }
  void logout() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    await share.clear();
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login2()),
    );
  }
  void Addnote()async{
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setString('title', title.text.toString());
    data.setString('description', description.text.toString());
    final newNote = Notes(
        title: title.text.toString(),
        description: description.text.toString());
    setState(() {
     NoteList.add(newNote);
    });
  }
  void deleteNote(int index) async {
   SharedPreferences data = await SharedPreferences.getInstance();
   await data.remove('title$index');
   await data.remove('description$index');
   setState(() {
     NoteList.removeAt(index);
   });
  }
  void editNote(int index) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    // Get the current values of the note
    String currentTitle = data.getString('title$index') ?? '';
    String currentDescription = data.getString('description$index') ?? '';
    // Show the edit dialog to update the note
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: TextEditingController(text: currentTitle),
                onChanged: (value) {
                  currentTitle = value;
                },
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextFormField(
                controller: TextEditingController(text: currentDescription),
                onChanged: (value) {
                  currentDescription = value;
                },
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the note in SharedPreferences
                await data.setString('title$index', currentTitle);
                await data.setString('description$index', currentDescription);

                // Update the note in the NoteList
                setState(() {
                  NoteList[index].title = currentTitle;
                  NoteList[index].description = currentDescription;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }


}


