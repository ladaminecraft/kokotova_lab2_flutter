import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<FanHTTP> fetchFanFromServer(String url) async{
  final response = await http.get(Uri.parse(url)
  );
  

  return FanHTTP.fromJson(jsonDecode(response.body));
}

class FanHTTP {

  final String name;
  final String nickname;
  final String birthday;
  final String img;


const FanHTTP({
  required this.name,
  required this.nickname,
  required this.birthday,
  required this.img,

  });

  factory FanHTTP.fromJson(List<dynamic> rawData) {
    return FanHTTP(
      name: rawData.first["name"],
      nickname: rawData.first["nickname"],
      birthday: rawData.first["birthday"],
      img: rawData.first["img"],
    );
  }
}


class SecondPage extends StatefulWidget {
  const SecondPage({
    required this.url,
    Key? key,}) : super(key: key);

    final String url;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<FanHTTP> futureFanFromServer;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
       appBar: AppBar(
        title: Text("Info"),
      ),
        body: Center(
          child: FutureBuilder<FanHTTP>(
            future: fetchFanFromServer(widget.url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  color: Color.fromARGB(255, 255, 0, 98),
                  width: 500,
                  height: 600,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children:  <Widget>[
                    Text(snapshot.data!.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                    Text(snapshot.data!.nickname, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                    Text(snapshot.data!.birthday, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
                    Image.network(snapshot.data!.img, height: 350),]
                    )
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      
    );
  }
}
