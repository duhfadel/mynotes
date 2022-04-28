import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'note.dart';
import 'notes.dart';
import 'editnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notesList = [];

  @override
  void initState() {
    super.initState();
    _initNotes();
  }

  //Using json
  void _initNotes() async {
    try {
      List<dynamic> tempList = json.decode(await readData());
      setState(() {
        notesList = tempList.map((e) => Note.fromJson(e)).toList();
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes For You'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.docs[index].id),
                        subtitle: Text(
                            (snapshot.data!.docs[index].data() as Map)['text']),
                        onTap: () {
                          _navegatorEditNote(context, notesList[index]);
                        },
                      );
                    });
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navegatorNewNote(context);
        },
      ),
    );
  }

  Future<void> _navegatorEditNote(BuildContext context, Note note) async {
    Note note2 = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditNotePage(note: note)));
    setState(() {
      note = note2;
    });
  }

  Future<void> _navegatorNewNote(BuildContext context) async {
    Note? note = await Navigator.push<Note>(
        context, MaterialPageRoute(builder: (context) => NewNotePage()));
    addList(note);
    addBank(note);
  }

  void addList(Note? note) {
    if (note != null) {
      setState(() {
        notesList.add(note);
        //saveData(notesList);
      });
    }
  }

  /* Function for path json file */
  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  /* Function to save into json file 
  Future<File> saveData(List<Note> notesList) async {
    String data = json.encode(notesList);
    final file = await getFile();
    print(data);
    return file.writeAsString(data);
  }
  */

  /* Function to read json data */
  Future<String> readData() async {
    try {
      final file = await getFile();
      String teste = await file.readAsString();
      return teste;
    } catch (e) {
      return '';
    }
  }

  //Function to add on database
  addBank(Note? note) {
    if (note != null) {
      FirebaseFirestore.instance
          .collection('Notes')
          .doc(note.title)
          .set({'text': note.description});
    }
  }
}

/*ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notesList[index].title),
              subtitle: Text(notesList[index].description),
              onTap: () {
                _navegatorEditNote(context, notesList[index]);
              },
            );
          }), */