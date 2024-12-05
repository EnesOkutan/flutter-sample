class Todo {
  int id;
  String title;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'isDone': isDone
    };
  }
}