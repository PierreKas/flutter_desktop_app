import 'dart:async';

import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/buttons.dart';
import 'package:le_coin_des_cuisiniers_app/components/text_content.dart';
import 'package:le_coin_des_cuisiniers_app/components/text_hearder.dart';
import 'package:le_coin_des_cuisiniers_app/controller/users_controller.dart';
import 'package:le_coin_des_cuisiniers_app/models/users.dart';
import 'package:le_coin_des_cuisiniers_app/views/user/add_user.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    super.initState();
    getUsersList();
  }

  List<User> usersList = [];
  Future<List<User>> getUsersList() async {
    usersList = await UsersController().getUsers(context);
    return usersList;
  }

  Widget dataTable() {
    final columns = [
      'Nom complet',
      'Adresse',
      'Numéro',
      'Email',
      'Mot de passe',
      'Etat du compte'
    ];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(usersList),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(
              label: Text(column),
            ))
        .toList();
  }

  List<DataRow> getRows(List<User> usersList) {
    return usersList.map((User user) {
      final cells = [
        user.fullName,
        user.address,
        user.phoneNumber,
        user.email,
        user.password,
        user.userStatus
      ];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells
        .map((data) => DataCell(
              Text('$data'),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            MyTextHeader(content: 'Le coins des cuisiniers'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextContent(content: 'Liste des utilisateur'),
                MyButtons(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddUser()));
                    },
                    text: 'Ajouter un nouveau utilisateur')
              ],
            ),
            dataTable(),
          ],
        ),
      ),
    );
  }
}
