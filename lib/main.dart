import 'package:flutter/material.dart';
import './misc/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 25, 195, 10)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Get A Good News Every Day'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Author Name",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Image.network(
              'https://images.squarespace-cdn.com/content/v1/647e19ffc1836a5f26764e43/91d4e109-23fc-4c77-b3d7-4c92f33d268d/A+journey+of+a+thousand+miles.png?format=1500w',

            ),
            Text(
              "Quote placeholder",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Hello $friend"
            )
          ],
        ),
      ),
    );
  }
}
