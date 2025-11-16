import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Application',
      debugShowCheckedModeBanner: false,
      home: const CounterHomePage(),
    );
  }
}

class CounterHomePage extends StatefulWidget {
  const CounterHomePage({super.key});
  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  int _counter = 0;
  Timer? _timer;

  bool get _isRunning => _timer?.isActive ?? false;

  void _startCounter() {
    if (_isRunning) return;              // avoid multiple timers
    setState(() {
      _counter = 1;                      // start from One
    });
    // increment every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _counter++;
      });
    });
  }

  void _stopCounter() {
    _timer?.cancel();
    _timer = null;
    setState(() {}); // update UI (buttons)
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNTER APPLICATION'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Counter Value', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isRunning ? null : _startCounter,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                child: Text('START'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isRunning ? _stopCounter : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                child: Text('STOP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
