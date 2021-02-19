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
        title: Text("Pokemon App ^v^"),
         
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    
                                    decoration: BoxDecoration(
                                      
                                      
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
      drawer: Drawer(
      
          child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(379),
          color: Colors.amber[300],
           
        )
      ])
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.grey,
          child: Icon(Icons.refresh)),
    );
  }
}
