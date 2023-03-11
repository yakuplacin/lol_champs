import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lol_champs/information_champs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends Heroes',
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
        "http://ddragon.leagueoflegends.com/cdn/13.1.1/data/en_US/champion.json"));
    print(result);
    print(result.body);
    setState(() {
      check = true;
      response = json.decode(result.body);
      print("HERE\n");
      print(response["data"]["Ahri"]["version"]);
    });
  }

  String url = "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/";

  List champs = [
    "Aatrox",
    "Ahri",
    "Akali",
    "Akshan",
    "Alistar",
    "Amumu",
    "Anivia",
    "Annie",
    "Aphelios",
    "Ashe",
    "AurelionSol",
    "Azir",
    "Bard",
    "Belveth",
    "Blitzcrank",
    "Brand",
    "Braum",
    "Caitlyn",
    "Camille",
    "Cassiopeia",
    "Chogath",
    "Corki",
    "Darius",
    "DrMundo",
    "Draven",
    "Ekko",
    "Elise",
    "Evelynn",
    "Ezreal",
    "Fiddlesticks",
    "Fiora",
    "Fizz",
    "Galio",
    "Gangplank",
    "Garen",
    "Gnar",
    "Gragas",
    "Graves",
    "Gwen",
    "Hecarim",
    "Heimerdinger",
    "Illaoi",
    "Irelia",
    "Ivern",
    "Janna",
    "JarvanIV",
    "Jax",
    "Jayce",
    "Jhin",
    "Jinx",
    "KSante",
    "Kaisa",
    "Kalista",
    "Karma",
    "Karthus",
    "Kassadin",
    "Katarina",
    "Kayle",
    "Kayn",
    "Kennen",
    "Khazix",
    "Kindred",
    "Kled",
    "KogMaw",
    "Leblanc",
    "LeeSin",
    "Leona",
    "Lillia",
    "Lissandra",
    "Lucian",
    "Lulu",
    "Lux",
    "Malphite",
    "Malzahar",
    "Maokai",
    "MasterYi",
    "MissFortune",
    "Mordekaiser",
    "Morgana",
    "Nami",
    "Nasus",
    "Nautilus",
    "Neeko",
    "Nidalee",
    "Nilah",
    "Nocturne",
    "Nunu",
    "Olaf",
    "Orianna",
    "Ornn",
    "Pantheon",
    "Poppy",
    "Pyke",
    "Qiyana",
    "Quinn",
    "Rakan",
    "Rammus",
    "RekSai",
    "Rell",
    "Renata",
    "Renekton",
    "Rengar",
    "Riven",
    "Rumble",
    "Ryze",
    "Samira",
    "Sejuani",
    "Senna",
    "Seraphine",
    "Sett",
    "Shaco",
    "Shen",
    "Shyvana",
    "Singed",
    "Sion",
    "Sivir",
    "Skarner",
    "Sona",
    "Soraka",
    "Swain",
    "Sylas",
    "Syndra",
    "TahmKench",
    "Taliyah",
    "Talon",
    "Taric",
    "Teemo",
    "Thresh",
    "Tristana",
    "Trundle",
    "Tryndamere",
    "TwistedFate",
    "Twitch",
    "Udyr",
    "Urgot",
    "Varus",
    "Vayne",
    "Veigar",
    "Velkoz",
    "Vex",
    "Vi",
    "Viego",
    "Viktor",
    "Vladimir",
    "Volibear",
    "Warwick",
    "MonkeyKing",
    "Xayah",
    "Xerath",
    "XinZhao",
    "Yasuo",
    "Yone",
    "Yorick",
    "Yuumi",
    "Zac",
    "Zed",
    "Zeri",
    "Ziggs",
    "Zilean",
    "Zoe",
  ];

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
            ? const CircularProgressIndicator()
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
                            ("${url + champs[index]}_0.jpg"),
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
                                color: Colors.white,
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
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0),
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
