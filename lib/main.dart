import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pokepoke.dart';
import "package:http/http.dart" as http;

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

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  
  PokeUhuy pokeUhuy; 

  @override
  void initState(){
    super.initState();
    fetchData();
    print("2nd work");
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
    var map = pokeUhuy.pokemon.map((poke) => Card());
    var scaffold3 = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Poke App"),
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
                            var materialPageRoute = MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        ));
                            Navigator.push(
                                context,
                                materialPageRoute);
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.grey,
            child: Icon(Icons.refresh)
            ),
    );
  }
}
