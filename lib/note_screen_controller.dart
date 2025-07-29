import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_hive/customsnack_baar.dart';

class NoteScreenController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var noteList = [].obs;
  var myBox = Hive.box("notesData");

  @override
  void onInit() {
    super.onInit();
    getNoteListData();
    print("noteList: $noteList");
  }

  addData(var data) async {
    await myBox.add(data);
    CustomSnackBar("Note Added Successfully", "S");
    getNoteListData();
    titleController.clear();
    descriptionController.clear();
  }

  getNoteListData() {
    noteList.value = myBox.keys.map((key) {
      return {
        "key": key,
        "title": myBox.get(key)["title"],
        "description": myBox.get(key)["description"],
        "created_at": myBox.get(key)["created_at"],
      };
    }).toList();
  log("Note List Data: $noteList");
  }

  deleteNote(int key) async {
    await myBox.delete(key);
    CustomSnackBar("Note Deleted Successfully", "S");
    getNoteListData();
    titleController.clear();
    descriptionController.clear();
  }

  updateNote(int key, String title, String description) async {
    await myBox.put(key, {"title": title, "description": description,"created_at":noteList.firstWhere((element) => element['key'] == key)['created_at']});
    CustomSnackBar("Note Edited Successfully", "S");
    getNoteListData();
    titleController.clear();
    descriptionController.clear();
  }
}
