import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Dark To-Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent, // gradient will show
        primaryColor: Colors.tealAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const ToDoHome(),
    );
  }
}

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add({"title": _controller.text.trim(), "done": false});
      });
      _controller.clear();
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]["done"] = !_tasks[index]["done"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.blue, Colors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // transparent for gradient
        appBar: AppBar(
          title: const Text(
            "To-Do List",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.tealAccent,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.4),
                        hintText: "Enter Task",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text("Add"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                child: Text(
                  "No tasks yet, add some! 🎉",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    color: task["done"]
                        ? Colors.greenAccent.withOpacity(0.2)
                        : Colors.orangeAccent.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                          task["done"]
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: task["done"]
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                        ),
                        onPressed: () => _toggleTask(index),
                      ),
                      title: Text(
                        task["title"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: task["done"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task["done"]
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
