import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/event.dart';
import 'package:http/http.dart' as http;

class AdminEvent extends StatefulWidget {
  const AdminEvent({Key? key}) : super(key: key);

  @override
  _AdminEventState createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  late List<Event> listEvents = [];

  TextEditingController tecEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Evenements")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Début : "+ listEvents[index].start_datetime.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text("Fin : "+ listEvents[index].end_datetime.toString(),
                            style: const TextStyle(
                            )),
                        const Spacer(flex: 1,),
                        Text("Scène : "+ listEvents[index].stage.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Artiste(s) : "+ listEvents[index].artists.toString(),
                            style: const TextStyle(
                            )),
                        const Spacer(flex: 1,),
                        IconButton(
                            onPressed: () => _deleteEvent(listEvents[index].id.toString()),
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

  _fetchEvent() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/event'));

    if (response.statusCode == 200) {

      var mapEvents = jsonDecode(response.body);
      List<Event> events = List<Event>.from(
          mapEvents.map((events) => Event.fromJson(events))
      );
      _onReloadListView(events);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Event> events) {
    setState(() {
      listEvents = events;
      tecEvent.clear();
    });
  }

  _deleteEvent(String id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8000/event'+ id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Event supprimé de la programmation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchEvent();
    }

  }
}
