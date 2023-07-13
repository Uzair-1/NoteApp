
// ignore_for_file: file_names, camel_case_types

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


import '../datamodelbyHive.dart';

/*
Using the static keyword means that the method belongs to the class
itself rather than an instance of the class.
It allows you to access the method directly without
 creating an instance of the class.*/

class getBoxdata{
 static Box<NoteData> getData() => Hive.box<NoteData>('note');

}