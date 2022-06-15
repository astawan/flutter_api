import 'dart:convert';

import 'package:chat_app/add_form.dart';
import 'package:chat_app/edit_form.dart';
import 'package:chat_app/zodiac.class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  late Future<List<Zodiac>> futureZodiac;
  List<Zodiac> zodiacs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureZodiac = fetchZodiac();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Zodiac>>(
        future: futureZodiac,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            zodiacs = snapshot.data!;
            return ListView.builder(
              itemCount: zodiacs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _navigateAndDisplayEditForm(context, index),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          zodiacs[index].photo,
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
                                  zodiacs[index].name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(zodiacs[index].date),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  zodiacs[index].description,
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
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplayAddForm(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<List<Zodiac>> fetchZodiac() async {
    final res = await http.get(Uri.parse('http://localhost/zodiac/get.php'));

    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(res.body)['data'];
      List<Zodiac> listZodiac = [];
      for (var dat in data) {
        listZodiac.add(Zodiac.fromJson(dat));
      }
      return listZodiac;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplayAddForm(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddForm()),
    );
    if (result != null) {
      setState(() {
        zodiacs.add(result);
      });
    }
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplayEditForm(BuildContext context, int index) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditForm(data: zodiacs[index]),
      ),
    );
    if (result != null) {
      setState(() {
        zodiacs[index] = result;
      });
    }
  }
}
