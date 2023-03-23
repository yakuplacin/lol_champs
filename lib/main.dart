import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lol_champs/information_champs.dart';

import 'champs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends Heroes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Map<String, dynamic> response;

  @override
  void initState() {
    setState(() {
      fetchHeroes();
    });
    super.initState();
  }

  bool check = false;

  Future<void> fetchHeroes() async {
    var result = await http.get(Uri.parse(
        "http://ddragon.leagueoflegends.com/cdn/13.1.1/data/tr_TR/champion.json"));
    print(result);
    print(result.body);
    setState(() {
      check = true;
      response = json.decode(utf8.decode(result
          .bodyBytes)); //Here, For the characters that are not in English, you should use this one.
      print("HERE\n");
      print(response["data"]["Ahri"]["version"]);
    });
  }

  String url = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0.1,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A4256), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text("League Of Legends"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {},
            )
          ],
        ),
        body: !check
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: champs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InformationChamps(
                            response,
                            champs[index],
                            ("${url + champs[index]}_1.jpg"),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(64, 75, 96, .9),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${url + champs[index]}_0.jpg"),
                            ),
                          ),
                          title: Text(
                            response["data"][champs[index]] != null
                                ? "${response["data"][champs[index]]["name"]}"
                                : "",
                            style: const TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 1.0),
                                  child: Text(
                                    response["data"][champs[index]] != null
                                        ? "${response["data"][champs[index]]["title"]}"
                                        : "",
                                    style: const TextStyle(color: Colors.yellowAccent),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right,
                              color: Colors.greenAccent, size: 30.0),
                        ),
                      ),

                      // child: Column(
                      //   //      mainAxisAlignment: MainAxisAlignment.start,
                      //   //       crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       response["data"][champs[index]] != null
                      //           ? "${response["data"][champs[index]]["name"]}"
                      //           : "",
                      //       style: TextStyle(color: Colors.black54),
                      //     ),
                      //     Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: CircleAvatar(
                      //             backgroundImage: NetworkImage(
                      //                 url + champs[index] + "_0.jpg")))
                      //   ],
                      // ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
