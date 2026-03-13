import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0xFFFCD614)),
      ),
      home: const MyHomePage(title: 'Инкремент'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void incrementClear() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Значение инкремента:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
                mainAxisAlignment: .center,
              children: [
                FloatingActionButton(
                  onPressed: decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                  backgroundColor: Colors.red,
                ),
                FloatingActionButton(
                  onPressed: incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.green,
                ),
              ]
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                overlayColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? Colors.grey.shade200 : null),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: incrementClear,
              child: Text('Сбросить'), // Текст кнопки
            )
          ],
        ),
      ),
    );
  }
}
