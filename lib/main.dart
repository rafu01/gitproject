import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gitproject/model/TechCrunchNewsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> data = List<Articles>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my title"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Text('data recieved');
                }
              }),
        ],
      ),
    );
  }
}

getData() async {
  try {
    http.Response response = await http.get(
        "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6669c42118fb40ab8a0a88aa4dfddf2a");
    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> articles = map["articles"];
    for (int i = 0; i < articles.length; i++) {
      Articles ar = Articles.fromJson(articles[i]);
      print(ar.title);
    }
  } catch (e) {}
}
