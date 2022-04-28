import 'package:flutter/material.dart';
import 'notes.dart';

class NewNotePage extends StatelessWidget {
  NewNotePage({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: ('Title'),
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: [
            TextField(
              controller: descriptionController,
            ),
            ElevatedButton(
              onPressed: () {
                Note note2 = Note(
                    title: titleController.text,
                    description: descriptionController.text);
                //Use <Nota>
                Navigator.of(context).pop<Note>(note2);
              },
              child: const Text('Save'),
            ),
          ],
        ));
  }
}
