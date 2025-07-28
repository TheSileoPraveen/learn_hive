import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_hive/note_description_screen.dart';
import 'package:learn_hive/note_screen_controller.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});
  NoteScreenController noteScreenController = Get.put(NoteScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            elevation: 3,
            title: const Text(
              'Your Notes  📝',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
        ),
        body: noteScreenController.noteList.isEmpty
            ? Center(child: Text("Please add some note to show your notes"))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2 / 2, // Width to height ratio
                ),
                padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
                itemCount: noteScreenController.noteList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        NoteDescriptionScreen(),
                        arguments: {
                          'title':
                              '${noteScreenController.noteList[index]['title']}',
                          'description':
                              '${noteScreenController.noteList[index]['description']}',
                              "created_at":
                              '${noteScreenController.noteList[index]['created_at']}',
                          'key': noteScreenController.noteList[index]['key'],
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              noteScreenController.noteList[index]['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Flexible(
                              child: Text(
                                noteScreenController
                                    .noteList[index]['description'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 40,
                              children: [
                                InkWell(
                                  onTap: () {
                                    addNotes(
                                      title: noteScreenController
                                          .noteList[index]['title'],
                                      description: noteScreenController
                                          .noteList[index]['description'],
                                      key: noteScreenController
                                          .noteList[index]['key'],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "Title",
                                      titlePadding: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                      ),
                                      titleStyle: const TextStyle(
                                        fontSize: 20,

                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 18,
                                        bottom: 30,
                                      ),
                                      content: Padding(
                                        padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          'Are you sure you want to delete this note?',
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            fontSize: 14,

                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      radius: 15,
                                      actions: [
                                        SizedBox(
                                          width: 100,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.grey.shade400,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                            ),
                                            child: Text(
                                              "cancel",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ), // space between buttons
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () {
                                            noteScreenController.deleteNote(
                                              noteScreenController
                                                  .noteList[index]['key'],
                                            );

                                            Get.back();
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Created At :",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM, EEE, yyyy').format(
                                    DateTime.parse(
                                      noteScreenController
                                          .noteList[index]['created_at'],
                                    ),
                                  ),
                                
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

        floatingActionButton: SizedBox(
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              addNotes();
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            tooltip: 'Add Note',
            child: Center(
              child: const Text(
                "Add (+)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addNotes({String title = "", String description = "", int key = 0}) {
    if (title.isNotEmpty || description.isNotEmpty) {
      noteScreenController.titleController.text = title;
      noteScreenController.descriptionController.text = description;
    } else {
      noteScreenController.titleController.clear();
      noteScreenController.descriptionController.clear();
    }
    return Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    maxLines: 1,

                    cursorColor: Colors.black,

                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    controller: noteScreenController.titleController,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter Title",
                      filled: false,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      fillColor: Colors.green,

                      // Default border color (white)
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Border when the field is enabled (white)
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Border when the field is focused (white)
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    maxLines: 3,

                    cursorColor: Colors.black,
                    controller: noteScreenController.descriptionController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      counterText: "",
                      hintText: " Enter Decscription",
                      filled: false,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      fillColor: Colors.green,
                      // Default border color (white)
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Border when the field is enabled (white)
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Border when the field is focused (white)
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (title.isNotEmpty || description.isNotEmpty) {
                      noteScreenController.updateNote(
                        key,
                        noteScreenController.titleController.text,
                        noteScreenController.descriptionController.text,
                      );
                    } else {
                      noteScreenController.addData({
                        'title': noteScreenController.titleController.text,
                        'description':
                            noteScreenController.descriptionController.text,
                        "created_at": DateTime.now().toString(),
                      });
                    }

                    // Close the bottom sheet after adding the note
                    Get.back();
                  },
                  child: Text(
                    (title.isNotEmpty || description.isNotEmpty)
                        ? "Update Note"
                        : 'Save Note',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
