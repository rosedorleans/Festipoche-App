import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/user.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late List<User> listeUsers = [];

  TextEditingController tecUser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Utilisateur")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listeUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listeUsers[index].email.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text(
                            "Artiste : " + listeUsers[index].toString(),
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
      var mapUsers = jsonDecode(response.body);
      List<User> stages = List<User>.from(
          mapUsers.map((users) => User.fromJson(users))
      );
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<User> users) {
    setState(() {
      tecUser.clear();
    });
  }

}


