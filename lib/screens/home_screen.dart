
import 'package:flutter/material.dart';
import '../misc/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style:  TextStyle(fontSize: 24, color: Colors.amber.shade900)
          ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                "Author Name",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.replay_outlined),
                color: Colors.amber.shade900,
                iconSize: 21,
                onPressed: () => {
                  print("Icon button 1")
                },
              ),
            ),
            
            const Divider(
              color: Colors.amber,
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                'https://images.squarespace-cdn.com/content/v1/647e19ffc1836a5f26764e43/91d4e109-23fc-4c77-b3d7-4c92f33d268d/A+journey+of+a+thousand+miles.png?format=1500w',
								width: MediaQueryData.fromView(View.of(context)).size.width - 100,
              ),
            ),
						Row(
							mainAxisAlignment: MainAxisAlignment.end,
								children: [
									IconButton(
									onPressed: () {
										print("Elllooo.");
									}, 
									icon: const Icon(Icons.save),
									color: Colors.amber.shade900,
									iconSize: 27,
									
								),
							]
						),
						Text(
							"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
							style: Theme.of(context).textTheme.headlineSmall,
							textAlign: TextAlign.center,
							softWrap: true,
							overflow: TextOverflow.visible,
						),
						const Spacer(
              flex: 1,
            ),
            const Divider(
              color: Colors.amber,
            ),
            Text(
              "Hello $friend",
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      ),
    );
  }

}