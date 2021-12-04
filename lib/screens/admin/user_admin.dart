import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:festipoche/bo/user.dart';
import 'package:http/http.dart' as http;

class AdminUser extends StatefulWidget {
  const AdminUser({Key? key}) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  late List<User> listeUsers = [];

  TextEditingController tecUser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Users")),
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
                        Text("Email : "+ listeUsers[index].email.toString(),
                            style: const TextStyle(

                            )),
                        const Spacer(flex: 1,),
                        Text("Rôle : "+ listeUsers[index].roles.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Mot de passe : "+ listeUsers[index].password.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        Text("Pass festival : "+ listeUsers[index].festivalPass.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                        const Spacer(flex: 10),
                        IconButton(
                            onPressed: () => _deleteUser(listeUsers[index].id.toString()),
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

  _fetchUser() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/user'));

    if (response.statusCode == 200) {

      var mapUsers = jsonDecode(response.body);
      List<User> users = List<User>.from(
          mapUsers.map((users) => User.fromJson(users))
      );
      _onReloadListView(users);
    } else {
      throw Exception('Erreur de chargement des données.');
    }
  }

  _onReloadListView(List<User> users) {
    setState(() {
      listeUsers = users;
      tecUser.clear();
    });
  }

  _deleteUser(String id) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8000/user'+ id));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Artist supprimé de la programmation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4
      );
      _fetchUser();
    }

  }
}
