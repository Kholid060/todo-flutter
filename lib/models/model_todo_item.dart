class ModelTodoItem {
  int id;
  bool done;
  String title;
  String createdAt;
  String description;

  ModelTodoItem({
    required this.id,
    required this.done,
    required this.title,
    this.description = '',
    required this.createdAt,
  });

   Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'done': done,
      'title': title,
      'createdAt': createdAt,
      'description': description,
    };

    return map;
  }
}