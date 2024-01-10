import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/models/model_todo_item.dart';
import 'package:todo/widgets/todo_stats.dart';
import 'package:todo/widgets/todo_tile.dart';

String greeting() {
  String value = 'Good Evening!';

  int hour = DateTime.now().hour;
  if (hour >= 0 && hour <= 12) { value = 'Good Morning!'; }
  else if (hour > 12 && hour <= 18) { value = 'Good Afternoon!'; }

  return value;
}

enum AddEditType {
  add,
  edit,
}

class TodoPage extends StatefulWidget {
  const TodoPage({ Key? key }) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<ModelTodoItem> items = [];
  late final ScrollController _scrollController;

  final _addTodoFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    items = List.generate(19, (index) => 
      ModelTodoItem(
        id: index,
        done: index.isOdd,
        createdAt: DateTime.now().toString(),
        title: 'Item $index',
        description: index.isEven ? 'hHahaha' : ''
      ),
    );

    _scrollController = ScrollController();

    super.initState();
  }

  void toggleItemDone(int id, bool done) {
    final itemIdx = items.indexWhere((element) => element.id == id);
    if (itemIdx == -1) return;

    setState(() {
      items[itemIdx].done = done;
    });
  }

  void deleteItem(int id) {
    final itemIdx = items.indexWhere((element) => element.id == id);
    if (itemIdx == -1) return;

    setState(() {
      items.removeAt(itemIdx);
    });
  }

  void addOrEditItem(BuildContext context, AddEditType type, [int? itemId]) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (type == AddEditType.edit) {
      final editItem = items.firstWhereOrNull((element) => element.id == itemId);
      if (itemId == null || editItem == null) return;

      titleController.text = editItem.title;
      descriptionController.text = editItem.description;
    }
  

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: 320,
            child: Form(
              key: _addTodoFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type == AddEditType.add ? 'Add task' : 'Edit task',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autofocus: true,
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'My task'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length <= 3) {
                          return 'Title must be greater than 3';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      controller: descriptionController,
                      decoration: const InputDecoration(hintText: 'Task description (optional)'),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(type == AddEditType.add ? 'Add task' : 'Update task'),
                        onPressed: () {
                          bool isInvalid = !(_addTodoFormKey.currentState?.validate() ?? false);
                          if (isInvalid) return;

                          if (type == AddEditType.add) {
                            final tempItem = ModelTodoItem(
                              done: false,
                              id: items.length + 1,
                              title: titleController.text,
                              createdAt: DateTime.now().toString(),
                              description: descriptionController.text,
                            );

                            setState(() {
                              items.add(tempItem);
                            });
                          } else {
                            final itemIdx = items.indexWhere((element) => element.id == itemId);
                            if (itemIdx != -1) {
                              setState(() {
                                items[itemIdx]
                                  ..title = titleController.text
                                  ..description = descriptionController.text;
                              });
                            }
                          }

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    final checkedList = items.where((element) => element.done).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditItem(context, AddEditType.add),
        child: const Icon(Icons.add, size: 24)
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TodoStats(
              title: greeting(),
              totalItems: items.length,
              completedCount: checkedList.length,
            )
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 14, bottom: 4),
              child: Text('Tasks', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20))
            )
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              final todoItem = items[items.length - 1 - index];

              return TodoTile(
                todoItem: todoItem, 
                onDelete: () => deleteItem(todoItem.id), 
                onChanged: (value) => toggleItemDone(todoItem.id, value), 
                onTap: () => addOrEditItem(context, AddEditType.edit, todoItem.id),
              );
            },
            itemCount: items.length,
          ),
          if (items.isEmpty) const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                child: Text('No tasks'),
              ),
            ),
          ) 
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}