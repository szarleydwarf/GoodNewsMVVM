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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade400),
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
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white)
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Author Name",
              style: Theme.of(context).textTheme.headlineLarge,
  
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              'https://images.squarespace-cdn.com/content/v1/647e19ffc1836a5f26764e43/91d4e109-23fc-4c77-b3d7-4c92f33d268d/A+journey+of+a+thousand+miles.png?format=1500w',

            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            const Divider(
              color: Colors.amber,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Hello $friend",
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
