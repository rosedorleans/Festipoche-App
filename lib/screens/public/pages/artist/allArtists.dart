import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/artist.dart';
import 'package:http/http.dart' as http;

class AllArtists extends StatefulWidget {
  const AllArtists({Key? key}) : super(key: key);

  @override
  _AllArtistsState createState() => _AllArtistsState();
}

class _AllArtistsState extends State<AllArtists> {
  late List<Artist> listeArtists = [];

  TextEditingController tecArtist = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Artistes")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeArtists.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeArtists[index].name.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text(
                            "Artiste : " + listeArtists[index].event.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _fetchArtist() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/artist'));

    if (response.statusCode == 200) {
      var mapArtists = jsonDecode(response.body);
      List<Artist> artists = List<Artist>.from(
          mapArtists.map((artists) => Artist.fromJson(artists))
      );
      _onReloadListView(artists);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Artist> artists) {
    setState(() {
      listeArtists = artists;
      tecArtist.clear();
    });
  }

}


