import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rashmika",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = response.body;
    print(data);
    print(jsonDecode(data));
    return jsonDecode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity 01"),
      ),
      body: (FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot users) {
          if (users.hasData) {
            return ListView.separated(
              itemCount: users.data.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Color.fromARGB(255, 234, 64, 121),
                height: 5,
                thickness: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    users.data[index]["name"],
                    style: TextStyle(
                        color: Color.fromARGB(255, 6, 1, 1), fontSize: 30),
                  ),
                  subtitle: Text(users.data[index]["email"],
                      style: TextStyle(fontSize: 20)),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
