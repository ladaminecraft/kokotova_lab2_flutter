import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<http.Response> fetchgetFan() {
  return http.get(Uri.parse('https://www.breakingbadapi.com/api/characters/1'));
}

class FanHTTP {
  final int id;
  final int name;
  //late final Image image;

const FanHTTP({
  required this.name,
  required this.id,
  });

  factory FanHTTP.fromJson(Map<String, dynamic> json) {
    return FanHTTP(
      name: json['name'],
      id: json['id'],
    );
  }
}

void main() => runApp(const SecondPage());

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, String url}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<FanHTTP> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = getFan(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<FanHTTP>(
            future: fetchgetFan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.id);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
