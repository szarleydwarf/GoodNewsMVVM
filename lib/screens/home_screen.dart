import 'package:flutter/material.dart';
import 'package:good_news_app/networking/network_manager.dart';
import 'package:good_news_app/screen_elements/home_elements.dart';
import '../misc/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Quote> futureQuote;
  final bool userExist = false;

  @override
  void initState() {
    super.initState();
    futureQuote = NetworkManager().fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenElements(context, userExist).getFutureDataFrom(futureQuote);
  }
}
