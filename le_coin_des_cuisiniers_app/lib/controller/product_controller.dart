import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/snack_bar.dart';
import 'package:le_coin_des_cuisiniers_app/database/database_helper.dart';
import 'package:le_coin_des_cuisiniers_app/models/products.dart';
import 'package:le_coin_des_cuisiniers_app/views/product/products_list.dart';

class ProductController {
  final dbHelper = DatabaseHelper.instance;
  static List<Product> productsList = [];
  Future<void> addProduct(Product product, BuildContext context) async {
    if (
        // product.productCode.isEmpty ||
        // product.productName.isEmpty ||
        product.purchasePrice!.isNaN ||
            product.purchasePrice!.isNegative ||
            product.purchasedDate == null ||
            product.purchasedQuantity!.isNaN ||
            product.purchasedQuantity!.isNegative
        // product.sellingPrice < 1
        ) {
      MySnackBar.showErrorMessage(
          'Complète toutes sans erreur les cases', context);
    } else {
      await dbHelper.addProductToDB(product, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductsList()));
    }
  }

  Future<List<Product>> getProducts(BuildContext context) async {
    List<Product> allProducts = await dbHelper.readAllProducts(context);
    print(allProducts);
    return allProducts;
  }

  // Retrieve a specific product by product_code
  Future<Product?> getProductByCode(
      String prodCode, BuildContext context) async {
    Product? product = await dbHelper.readProductInformation(prodCode, context);

    return product;
  }

  Future<void> updateProduct(Product product, BuildContext context) async {
    if (
        // product.productCode.isEmpty ||
        // product.productName.isEmpty ||
        product.purchasePrice!.isNaN ||
            product.purchasePrice!.isNegative ||
            product.purchasedDate == null ||
            product.purchasedQuantity!.isNaN ||
            product.purchasedQuantity!.isNegative
        // product.sellingPrice < 1
        ) {
      MySnackBar.showErrorMessage(
          'Complète toutes sans erreur les cases', context);
    } else {
      await dbHelper.updateProductData(product, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductsList()));
    }
  }

  Future<void> deleteProduct(String prodCode, BuildContext context) async {
    await dbHelper.deleteProductFromDB(prodCode, context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductsList()));
  }
}
