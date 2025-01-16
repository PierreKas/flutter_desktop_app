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
import 'package:le_coin_des_cuisiniers_app/views/product/update_product.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
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
      'Prix d\'achat',
      'Autres dépenses',
      'Prix de revient',
      'Prix de vente',
      'Bénefice estimé',
      'Quantité acheté',
      'Date d\'achat',
      'Marque',
      'Quantité restante',
      'Actions'
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

  void _showDeleteConfirmationDialog(String productCode) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Veux-tu réellement supprimé ce produit?\n Toutes ses données seront perdues'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Non',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Dismiss the dialog first
                Navigator.of(dialogContext).pop();

                // Perform the deletion
                ProductController().deleteProduct(productCode, context);
              },
              child: const Text(
                'Oui',
                style: TextStyle(color: Color.fromARGB(255, 70, 103, 71)),
              ),
            ),
          ],
        );
      },
    );
  }

  List<DataRow> getRows(List<Product> productsList) {
    final dateFormatter = DateFormat('dd-MM-yyyy');

    return productsList.map((Product product) {
      return DataRow(cells: [
        DataCell(Text(product.productName!)),
        DataCell(Text(product.purchasePrice.toString())),
        DataCell(Text(product.otherExpenses.toString())),
        DataCell(Text(
            ((product.purchasePrice ?? 0.0) + (product.otherExpenses ?? 0.0))
                .toString())),
        DataCell(Text(product.sellingPrice.toString())),
        DataCell(Text(((product.sellingPrice ?? 0.0) -
                ((product.purchasePrice ?? 0.0) +
                    (product.otherExpenses ?? 0.0)))
            .toStringAsFixed(3))),
        DataCell(Text(product.purchasedQuantity.toString())),
        DataCell(Text(dateFormatter.format(product.purchasedDate!))),
        DataCell(Text(product.brand!)),
        DataCell(Text(product.remainingQuantity.toString())),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProduct(
                                  prCode: product.productCode!,
                                )));
                  },
                  child: Icon(Icons.edit),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _showDeleteConfirmationDialog(product.productCode!);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
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
      appBar: AppBar(
        title: Center(child: MyTextHeader(content: 'Le coin des cuisiniers')),
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextContent(content: 'Liste des produits'),
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
                  MyButtons(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                    text: 'Ajouter un nouveau produit',
                  )
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
