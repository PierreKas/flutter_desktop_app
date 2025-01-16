import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/snack_bar.dart';
import 'package:le_coin_des_cuisiniers_app/database/database_helper.dart';
import 'package:le_coin_des_cuisiniers_app/models/users.dart';

import 'package:le_coin_des_cuisiniers_app/views/product/products_list.dart';

class UsersController {
  final dbHelper = DatabaseHelper.instance;

  Future<void> addUser(User user, BuildContext context) async {
    if (user.fullName.isEmpty ||
        user.email.isEmpty ||
        user.phoneNumber.isEmpty ||
        user.address.isEmpty ||
        user.password.isEmpty) {
      MySnackBar.showErrorMessage('Complète toutes les cases', context);
    } else {
      await dbHelper.addUserToDB(user, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductsList()));
    }
  }

  Future<List<User>> getUsers(BuildContext context) async {
    List<User> allUsers = await dbHelper.readAllUsers(context);
    print(allUsers);
    return allUsers;
  }

  // Retrieve a specific user by email
  Future<User?> getUserByEmail(String email) async {
    User? user = await dbHelper.readUserInformation(email);
    return user;
  }

  Future<void> updateUser(User user) async {
    await dbHelper.updateUserData(user);
  }

  Future<void> deleteUser(String email) async {
    await dbHelper.deleteUserFromDB(email);
  }
}
