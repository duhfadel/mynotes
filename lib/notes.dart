

class Note {
 String title;
 String description;

  Note({required this.title, required this.description});

  Map<String, String> newNote = {};

    Note.fromJson(Map<String, dynamic> json)
        : title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };

}

