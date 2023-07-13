// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, file_names, non_constant_identifier_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internday1/NotesappHive/Boxes/Boxforgetdata.dart';
import 'package:internday1/NotesappHive/datamodelbyHive.dart';

import '../Loginforaharedperferenceconcept.dart';
import '../Loginpageforhiveconcept.dart';

class HivehomePage extends StatefulWidget {
  const HivehomePage({Key? key}) : super(key: key);

  @override
  State<HivehomePage> createState() => _HivehomePageState();
}

class _HivehomePageState extends State<HivehomePage> {
  late Box Boxdata;
  TextEditingController title =TextEditingController();
  TextEditingController description =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Notes App'),
            leading: Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: const Icon(Icons.account_circle_outlined),
            ),
            centerTitle: true,
            shadowColor: Colors.teal,
            titleSpacing: 10,
            actions: [
              GestureDetector(
                onTap: () async {
                  _LogoutDialog();
                },
                child: const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(Icons.logout_outlined),
                ),
              )
            ],
          ),
           body: ValueListenableBuilder<Box<NoteData>>(
               valueListenable: getBoxdata.getData().listenable(),
               builder: (context ,box ,_){
                 var data2 = box.values.toList()..cast<NoteData>();
                 return ListView.builder(
                   itemCount: box.length,
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
                                           Text(data2[index].title.toString()),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text("DESCRIPTION",style: TextStyle(color: Colors.brown.shade200,fontSize: 17),),
                                             ],
                                           ),
                                           Text(data2[index].description.toString()),
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
                 );
               }
           ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
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
              onPressed: () async {
                final data= NoteData(
                    title: title.text.toString(),
                    description: description.text.toString());
                   final box = getBoxdata.getData();
                   box.add(data);
                   // data.save();
                   // print(box);
                   title.clear();
                   description.clear();

                  // BoxesData = await Hive.openBox<NoteData>('note');
                  // BoxesData.get(data);
                  // print(data);
                  // data.save(); we also store data by doing this..

                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _LogoutDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
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
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: () {
                 logout();
              }, child: Text('Sure'),
              )
            ],
          );
        });
  }
  void logout() async {
   Boxdata= await Hive.openBox('log');
   Boxdata.delete('email');
   Boxdata.delete('password');
    // SharedPreferences share = await SharedPreferences.getInstance();
   // await share.clear();
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login3()),
    );
  }

  void deleteNote(int index){
  final box= getBoxdata.getData();
   box.deleteAt(index);
  }

  void editNote(int index) async {
    final box=getBoxdata.getData();
    NoteData? currentTitle= box.getAt(index);
    NoteData? currentDescription= box.getAt(index);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: TextEditingController(
                    text: currentTitle?.title ?? '',
                ),
                onChanged: (value) {
                  currentTitle?.title = value;
                },
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextFormField(
                controller: TextEditingController(
                    text: currentDescription?.description ?? '',
                ),
                onChanged: (value) {
                  currentDescription?.description = value;
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
               // await data.setString('title$index', currentTitle);
                //await data.setString('description$index', currentDescription);

                // Update the note in the NoteList
                setState(() {
                  //NoteList[index].title = currentTitle;
                 // NoteList[index].description = currentDescription;
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

