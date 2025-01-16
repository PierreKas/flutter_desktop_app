import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:le_coin_des_cuisiniers_app/components/buttons.dart';
import 'package:le_coin_des_cuisiniers_app/components/search_textfields.dart';
import 'package:le_coin_des_cuisiniers_app/components/text_content.dart';
import 'package:le_coin_des_cuisiniers_app/components/text_hearder.dart';
import 'package:le_coin_des_cuisiniers_app/controller/product_controller.dart';
import 'package:le_coin_des_cuisiniers_app/models/products.dart';
import 'package:le_coin_des_cuisiniers_app/views/product/add_product.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  @override
  void initState() {
    super.initState();
    getProductLists();
  }

  List<Product> productsList = [];
  List<Product> filteredProductsList = [];
  TextEditingController searchController = TextEditingController();
  Future<List<Product>> getProductLists() async {
    productsList = await ProductController().getProducts(context);
    filteredProductsList = productsList;
    setState(() {});
    return productsList;
  }

  void filterProducts(String query) {
    final filtered = productsList.where((product) {
      final productName = product.productName?.toLowerCase() ?? '';
      final input = query.toLowerCase();
      return productName.contains(input);
    }).toList();

    setState(() {
      filteredProductsList = filtered;
    });
  }

  Widget dataTable() {
    final columns = [
      'Nom du produit',
      'Prix de vente',
      'Marque',
      'Quantité restante',
    ];
    return DataTable(
      columns: getColumns(columns),
      // rows: getRows(productsList),
      rows: getRows(filteredProductsList),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(
              label: Text(column),
            ))
        .toList();
  }

  List<DataRow> getRows(List<Product> productsList) {
    // final dateFormatter = DateFormat('dd-MM-yyyy');

    return productsList.map((Product product) {
      return DataRow(cells: [
        DataCell(Text(product.productName!)),
        DataCell(Text(product.sellingPrice.toString())),
        DataCell(Text(product.brand!)),
        DataCell(Text(product.remainingQuantity.toString())),
      ]);
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const MyTextContent(content: 'Liste des produits'),
                  SizedBox(
                    width: 300,
                    child: MySearchTextField(
                      onChanged: filterProducts,
                      controller: searchController,
                      enabled: true,
                      hintText: 'Chercher un produit',
                      obscureText: false,
                      prefixIcon: Icons.search,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: dataTable(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
