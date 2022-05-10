import 'package:flutter/material.dart';
import 'notes.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    titleController = TextEditingController(text: widget.note.title);
    descriptionController =
        TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: (widget.note.title),
              labelStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: (String text) {
              widget.note.title = titleController.text;
            },
          ),
        ),
        body: Column(
          children: [
            TextField(
              controller: descriptionController,
              onChanged: (String text) {
                widget.note.description = descriptionController.text;
              },
            ),
            ElevatedButton(
              onPressed: () {
                widget.note.title = titleController.text;
                widget.note.description = descriptionController.text;
                //Use <Nota>
                Navigator.of(context).pop<Note>(widget.note);
              },
              child: const Text('Save'),
            ),
          ],
        ));
  }
}
