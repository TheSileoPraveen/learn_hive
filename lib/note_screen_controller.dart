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
  }

  getNoteListData() {
    noteList.value = myBox.keys.map((key) {
      return {
        "key": key,
        "title": myBox.get(key)["title"],
        "description": myBox.get(key)["description"],
      };
    }).toList();
  }

  deleteNote(int key) async {
    await myBox.delete(key);
    CustomSnackBar("Note Deleted Successfully", "S");
    getNoteListData();
  }

  updateNote(int key, String title, String description) async {
    await myBox.put(key, {"title": title, "description": description});
    CustomSnackBar("Note Edited Successfully", "S");
    getNoteListData();
  }
}
