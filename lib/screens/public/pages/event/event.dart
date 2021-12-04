import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/event.dart';
import 'package:http/http.dart' as http;

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  late List<Event> listeEvents = [];

  TextEditingController tecEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Evénement")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeEvents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1,),
                        Text(
                            "Evénement : " + listeEvents[index].toString(),
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

  _fetchEvent() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/event'));

    if (response.statusCode == 200) {
      var mapEvents = jsonDecode(response.body);
      List<Event> Events = List<Event>.from(
          mapEvents.map((artists) => Event.fromJson(artists))
      );
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<Event> Events) {
    setState(() {
      tecEvent.clear();
    });
  }

}


