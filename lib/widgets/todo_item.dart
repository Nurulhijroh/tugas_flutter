class TodoItem extends StatelessWidget {
  final TodoItemData todo;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;
  final VoidCallback onEdit;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onToggleCompletion,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          todo.text,
          style: TextStyle(
            decoration:
                todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                todo.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: todo.isCompleted ? Colors.green : Colors.black,
              ),
              onPressed: onToggleCompletion,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
