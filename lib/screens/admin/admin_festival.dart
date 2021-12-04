import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/festival.dart';
import 'package:http/http.dart' as http;

class AdminFestival extends StatefulWidget {
  const AdminFestival({Key? key}) : super(key: key);

  @override
  _AdminFestivalState createState() => _AdminFestivalState();
}

class _AdminFestivalState extends State<AdminFestival> {
  late List<Festival> listeFestivals = [];

  TextEditingController tecFestival = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFestival();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Festivales")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeFestivals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeFestivals[index].name.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text("Début : "+ listeFestivals[index].start_date.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Fin : "+ listeFestivals[index].end_date.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Scènes : "+ listeFestivals[index].stages.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        IconButton(
                            onPressed: () => _deleteFestival(listeFestivals[index].id.toString()),
                            icon: const Icon(Icons.delete)
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _fetchFestival() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/festival'));

    if (response.statusCode == 200) {

      var mapFestivals = jsonDecode(response.body);
      List<Festival> festivals = List<Festival>.from(
          mapFestivals.map((festivals) => Festival.fromJson(festivals))
      );
      _onReloadListView(festivals);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Festival> festivals) {
    setState(() {
      listeFestivals = festivals;
      tecFestival.clear();
    });
  }

  _deleteFestival(String id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8000/festival'+ id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Artist supprimé de la programmation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchFestival();
    }

  }
}
