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
}