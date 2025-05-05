import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My List',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[400],
        primarySwatch: Colors.blue,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<TodoItemData> _todos = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addTodo() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(TodoItemData(text: text, isCompleted: false));
        _controller.clear();
      });
    }
  }

  void _onButtonPressed() async {
    await _animationController.reverse();
    _addTodo();
    await _animationController.forward();
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void _editTodo(int index) {
    final TextEditingController editController =
    TextEditingController(text: _todos[index].text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Tugas'),
        content: TextFieldS(
          controller: editController,
          decoration: const InputDecoration(
            hintText: 'Edit tugas',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text ('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todos[index].text = editController.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('My List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Masukkan daftar tugas',
                hintStyle: TextStyle(color: Colors.black54),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(
                    todo: _todos[index],
                    onDelete: () => _removeTodo(index),
                    onToggleCompletion: () => _toggleCompletion(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: _onButtonPressed,
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class TodoItemData {
  String text;
  bool isCompleted;

  TodoItemData({required this.text, required this.isCompleted});
}

class TodoItem extends StatelessWidget {
  final TodoItemData todo;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onToggleCompletion,
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
                todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                color: todo.isCompleted ? Colors.green : Colors.black,
              ),
              onPressed: onToggleCompletion,
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
