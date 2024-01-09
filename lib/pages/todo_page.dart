import 'package:flutter/material.dart';
import 'package:todo/models/model_todo_item.dart';
import 'package:todo/widgets/todo_stats.dart';
import 'package:todo/widgets/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({ Key? key }) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String greeting = 'Good evening!';
  List<ModelTodoItem> items = List.generate(15, (index) => 
    ModelTodoItem(done: index.isOdd, createdAt: DateTime.now().toString(), title: 'Item $index', description: index.isEven ? 'hHahaha' : ''),
  );

  @override
  Widget build(BuildContext context){
    final checkedList = items.where((element) => element.done).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 28),
        onPressed: () => print('Hello world')
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade900),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TodoStats(completedCount: checkedList.length, totalItems: items.length),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Tasks', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final todoItem = items[index];
                              return TodoTile(todoItem: todoItem, onChanged: (value) {
                                print(index);
                                setState(() {
                                  items[index].done = (value);
                                });
                              },);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}