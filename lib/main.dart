import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pokemondetail.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/pokepoke.dart';

void main() {
  runApp(new MaterialApp(
    title: "Poke App",
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeUhuy pokeUhuy;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeUhuy = PokeUhuy.fromJson(decodedJson);
    print(pokeUhuy.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Pokemon App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          )
        ],
      ),
      body: pokeUhuy == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeUhuy.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.amber[300],
                                          width: 9,
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(poke.name,
                                      style: TextStyle(fontSize: 20.0))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      /* drawer: Drawer(
          child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(379),
          color: Colors.amber[300],
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image:
                  NetworkImage('https://i.ibb.co/r4kC0fL/pokemonlogo-png.png'),
            ),
          ),
        )
      ])),*/
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.grey,
          child: Icon(Icons.refresh)),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final Pokemon = [
    "Bulbasaur",
    "Ivysaur",
    "Venusaur",
    "Charmander",
  ];

  final recentPokemon = [
    "Bulbasaur",
    "Ivysaur",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Container(
      color: Colors.amber,
      height: 100.0,
      width: 100.0,
      child: Card(
        color: Colors.amberAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentPokemon
        : Pokemon.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.android),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.brown[900], fontWeight: FontWeight.bold)),
          /*children : (
          TextSpan(
          text: suggestionList[index].substring(query.length),
          style:TextStyle(color:Colors.grey)
        )),*/
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
