class ModelTodoItem {
  bool done;
  String title;
  String createdAt;
  String description;

  ModelTodoItem({
    required this.done,
    required this.title,
    this.description = '',
    required this.createdAt,
  });
}