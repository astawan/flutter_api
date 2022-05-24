import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> listTiles = [
    {
      'photo': 'https://www.astrology-zodiac-signs.com/images/aquarius.jpg',
      'name': 'Aquarius',
      'date': 'January 20 - Febuary 18',
      'description': 'Aquarius is the sign different from the rest of the zodiac and people born with their Sun in it feel special.',
    },
    {
      'photo': 'https://www.astrology-zodiac-signs.com/images/pisces.jpg',
      'name': 'Pisces',
      'date': 'February 19 - March 20',
      'description':
          'Pisces are very friendly and often find themselves in company of very different people. They are selfless and always willing to help others, a very fine intent for as long as they don’t expect anything much in return.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: listTiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  listTiles[index]['photo'],
                  width: 75.0,
                  height: 75.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listTiles[index]['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(listTiles[index]['date']),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          listTiles[index]['description'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black.withOpacity(0.3)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.blue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
