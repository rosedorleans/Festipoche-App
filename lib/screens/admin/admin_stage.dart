import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/stage.dart';
import 'package:http/http.dart' as http;

class AdminStage extends StatefulWidget {
  const AdminStage({Key? key}) : super(key: key);

  @override
  _AdminStageState createState() => _AdminStageState();
}

class _AdminStageState extends State<AdminStage> {
  late List<Stage> listeStages = [];

  TextEditingController tecStage = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Stagees")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeStages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeStages[index].name.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text(listeStages[index].festival.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Evénements : "+ listeStages[index].events.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        IconButton(
                            onPressed: () => _deleteStage(listeStages[index].id.toString()),
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

  _fetchStage() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/stage'));

    if (response.statusCode == 200) {

      var mapStages = jsonDecode(response.body);
      List<Stage> stages = List<Stage>.from(
          mapStages.map((stages) => Stage.fromJson(stages))
      );
      _onReloadListView(stages);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Stage> stages) {
    setState(() {
      listeStages = stages;
      tecStage.clear();
    });
  }

  _deleteStage(String id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8000/stage'+ id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Stage supprimé de la programmation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchStage();
    }

  }
}
