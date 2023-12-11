import 'package:flutter/material.dart';
import 'package:good_news_app/misc/palet.dart';
import 'package:good_news_app/screens/home_screen.dart';
import 'package:video_player/video_player.dart';

import '../helpers/quote_manager.dart';
import '../misc/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(title: homePageTitle)),
      );
    });
    QuoteManager.instance;

    _controller = VideoPlayerController.asset('assets/splash.mp4');

    // Initialize the controller; autoplay video
    _initializeVideoPlayerFuture =
        _controller.initialize().then((value) => _controller.play());

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue400,
        body: Padding(
            padding: const EdgeInsets.all(wholeScreenPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(cornerRadius),
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ])));
  }
}
