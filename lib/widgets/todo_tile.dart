import 'package:flutter/material.dart';
import 'package:todo/models/model_todo_item.dart';

class TodoTile extends StatelessWidget {
  final ModelTodoItem todoItem;
  final Function(bool value) onChanged;

  const TodoTile({ 
    Key? key,
    required this.onChanged,
    required this.todoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: todoItem.done,
              shape: CircleBorder(),
              onChanged: (value) => onChanged(value ?? false),
            ),
          ),
          DefaultTextStyle.merge(
            style: TextStyle(decoration: todoItem.done ? TextDecoration.lineThrough : null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todoItem.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ...todoItem.description.isEmpty ? [] : [Text(todoItem.description, style: TextStyle(color: Colors.black54))],
              ],
            ),
          )
        ],
      ),
    );
  }
}