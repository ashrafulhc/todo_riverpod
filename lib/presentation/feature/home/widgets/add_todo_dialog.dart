import 'package:flutter/material.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key, required this.onAdd});
  final Function(TodoEntity) onAdd;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _todoController = TextEditingController();
  bool _isCompleted = false;

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _todoController,
            decoration: const InputDecoration(
              labelText: 'Todo',
              hintText: 'Enter your todo',
            ),
            autofocus: true,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value ?? false;
                  });
                },
              ),
              const Text('Completed'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_todoController.text.isNotEmpty) {
              final newTodo = TodoEntity(
                id: DateTime.now().millisecondsSinceEpoch,
                todo: _todoController.text,
                completed: _isCompleted,
                userId: 5, // Default user ID
              );
              widget.onAdd(newTodo);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
