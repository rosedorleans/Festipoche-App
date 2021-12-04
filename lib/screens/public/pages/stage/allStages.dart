import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/stage.dart';
import 'package:http/http.dart' as http;

class AllStages extends StatefulWidget {
  const AllStages({Key? key}) : super(key: key);

  @override
  _AllStagesState createState() => _AllStagesState();
}

class _AllStagesState extends State<AllStages> {
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
      appBar: AppBar(title: const Text("Liste des Scènes")),
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
                        Text(
                            "Artiste : " + listeStages[index].toString(),
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

  _fetchStage() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/stage'));

    if (response.statusCode == 200) {
      var mapStages = jsonDecode(response.body);
      List<Stage> stages = List<Stage>.from(
          mapStages.map((stages) => Stage.fromJson(stages))
      );
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Stage> stages) {
    setState(() {
      tecStage.clear();
    });
  }

}


