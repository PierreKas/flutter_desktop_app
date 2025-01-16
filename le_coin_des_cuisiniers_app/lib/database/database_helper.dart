import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/snack_bar.dart';
import 'package:le_coin_des_cuisiniers_app/components/toast_message.dart';
import 'package:le_coin_des_cuisiniers_app/models/products.dart';
import 'package:le_coin_des_cuisiniers_app/models/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('le_coin_des_cuisiniers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idPKType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE products (
      id $idPKType,
      product_code $textType,
      product_name $textType,
      purchase_price $intType,
      other_expenses $intType,
      selling_price $intType,
      purchased_quantity $intType,
      remaining_quantity $intType DEFAULT 0,
      purchased_date $textType,
      brand $textType
      
    )
    ''');

    await db.execute('''
    CREATE TABLE transactions(
      transaction_Id $idPKType,
      product_code $textType,
      product_Id $intType,
     quantity $intType,
     bill_code $textType,
     selling_date $textType,
     total_price $intType,
     FOREIGN KEY (product_Id ) REFERENCES products(id)
    )
    ''');
    // await db.execute('ALTER table products ADD column other_expenses $intType');
    // //await db.execute('ALTER table products DROP column other_expenses');
    await db.execute('''
    CREATE TABLE users (
      id $idPKType,
      full_name $textType,
      phone_number $textType,
      email $textType,
      address $textType,
      password $textType,
      user_status $textType DEFAULT 'NON AUTORISE'
      
    )
    ''');

    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  ///////////////////////////////////////////// Product-related operations//////////////////////////////////////////////////
// Insert a new product into the database
  Future<int> addProductToDB(Product product, BuildContext context) async {
    try {
      final db = await instance.database;
      print('Product created');
      MySnackBar.showSuccessMessage('Produit ajouté', context);
      return await db.insert('products', product.toJson());
    } on Exception catch (e) {
      print(e);
      MySnackBar.showSuccessMessage('L\'ajout a refusé', context);
      return 0;
      // TODO
    }
  }

  // Read all products from the database
  Future<List<Product>> readAllProducts(BuildContext context) async {
    final db = await instance.database;
    try {
      final result = await db.query('products');

      return result.map((json) => Product.fromJson(json)).toList();
    } on Exception catch (e) {
      print(e);

      MySnackBar.showErrorMessage(
          'Une erreur s\'est produite en voulant afficher la liste des produits',
          context);
      return [];
    }
  }

  // Read a single product by Code
  Future<Product?> readProductInformation(
      String prod_code, BuildContext context) async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'products',
        columns: [
          'product_code',
          'product_name',
          'purchase_price',
          'other_expenses',
          'selling_price',
          'purchased_quantity',
          'remaining_quantity',
          'purchased_date',
          'brand'
        ],
        where: 'product_code = ?',
        whereArgs: [prod_code],
      );

      if (result.isNotEmpty) {
        return Product.fromJson(result.first);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
      MySnackBar.showErrorMessage(
          'Une erreur s\'est produite en voulant afficher les informations du produit',
          context);
    }
    return null;
  }

  // Update an existing task
  Future<int> updateProductData(Product product, BuildContext context) async {
    try {
      final db = await instance.database;
      MySnackBar.showSuccessMessage('Modification effectué', context);
      return db.update(
        'products',
        product.toJson(),
        where: 'product_code = ?',
        whereArgs: [product.productCode],
      );
    } on Exception catch (e) {
      print(e);
      MySnackBar.showErrorMessage(
          'Une erreur s\'est produite en voulant modifier les informations du produit ${product.productName}',
          context);
      return 0;
    }
  }

  // Delete a task
  Future<int> deleteProductFromDB(
      String prod_code, BuildContext context) async {
    try {
      final db = await instance.database;
      MySnackBar.showErrorMessage('Suppression réussie', context);
      return await db.delete(
        'products',
        where: 'product_code = ?',
        whereArgs: [prod_code],
      );
    } on Exception catch (e) {
      print(e);
      MySnackBar.showErrorMessage(
          'Une erreur s\'est produite en voulant supprimer le produit',
          context);
      return 0;
    }
  }

  ///////////////////////////////////////////// User-related operations//////////////////////////////////////////////////

  Future<int> addUserToDB(User user, BuildContext context) async {
    try {
      final db = await instance.database;
      print('User created');
      MySnackBar.showSuccessMessage('Utilisateur ajouté', context);
      return await db.insert('users', user.toJson());
    } on Exception catch (e) {
      print(e);
      MySnackBar.showSuccessMessage('L\'ajout a refusé', context);
      return 0;
      // TODO
    }
  }

  // Read all products from the database
  Future<List<User>> readAllUsers(BuildContext context) async {
    final db = await instance.database;
    try {
      final result = await db.query('users');
      print('Raw DB Result: $result');
      return result.map((json) => User.fromJson(json)).toList();
    } on Exception catch (e) {
      print(e);

      MySnackBar.showErrorMessage(
          'Une erreur s\'est produite en voulant afficher la liste des utilisateurs',
          context);
      return [];
    }
  }

  // Read a single user by email
  Future<User?> readUserInformation(String email) async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'users',
        columns: [
          'full_name',
          'phone_number',
          'email',
          'address',
          'password',
          'user_status'
        ],
        where: 'email = ?',
        whereArgs: [email],
      );

      if (result.isNotEmpty) {
        return User.fromJson(result.first);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
      MyToast.showErrorMessage(
          'Une erreur s\'est produite en voulant afficher les informations de l\'utilisateur');
    }
    return null;
  }

  // Update an existing task
  Future<int> updateUserData(User user) async {
    try {
      final db = await instance.database;
      MyToast.showSuccessMessage('Données modifiées');
      return db.update(
        'users',
        user.toJson(),
        where: 'email = ?',
        whereArgs: [user.email],
      );
    } on Exception catch (e) {
      print(e);
      MyToast.showErrorMessage(
          'Une erreur s\'est produite en voulant modifier les informations de l\'utilisateur ${user.fullName}');
      return 0;
    }
  }

  // Delete a task
  Future<int> deleteUserFromDB(String email) async {
    try {
      final db = await instance.database;

      return await db.delete(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
    } on Exception catch (e) {
      print(e);
      MyToast.showErrorMessage(
          'Une erreur s\'est produite en voulant supprimer l\'utilisateur');
      return 0;
    }
  }
}
