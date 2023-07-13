// ignore_for_file: file_names

import 'package:hive_flutter/adapters.dart';
part 'datamodelbyHive.g.dart'; // we create a model to manage the data in hive.
@HiveType(typeId: 0)
class NoteData extends HiveObject { // due to extend, hive manage the indexs and give us access to save data
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  NoteData({
    required this.title,
    required this.description,
  });
}