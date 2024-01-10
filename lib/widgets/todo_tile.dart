import 'package:flutter/material.dart';
import 'package:todo/models/model_todo_item.dart';

class TodoTile extends StatelessWidget {
  final Function()? onTap;
  final Function()? onDelete;
  final ModelTodoItem todoItem;
  final Function(bool value) onChanged;

  const TodoTile({ 
    Key? key,
    this.onTap,
    this.onDelete,
    required this.onChanged,
    required this.todoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDelete?.call();
        },
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.only(right: 10),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text('Swipe to delete', style: TextStyle(color: Colors.white))
          ),
        ),
        key: Key(todoItem.id.toString()),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: todoItem.done,
                shape: const CircleBorder(),
                onChanged: (value) => onChanged(value ?? false),
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap?.call(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoItem.title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, decoration: todoItem.done ? TextDecoration.lineThrough : null)
                    ),
                    ...todoItem.description.isEmpty ? [] : [Text(todoItem.description, style: const TextStyle(color: Colors.black54))],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}