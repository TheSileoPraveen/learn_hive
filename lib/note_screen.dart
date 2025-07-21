import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2, // Width to height ratio
        ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        itemCount: 8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        'Derailed description of the note goes here.',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
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
            // Action to add a new note
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          tooltip: 'Add Note',
          child: Center(child: const Text("Add (+)", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }
}
