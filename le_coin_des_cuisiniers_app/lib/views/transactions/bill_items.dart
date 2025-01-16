// import 'package:flutter/material.dart';
// import 'package:le_coin_des_cuisiniers_app/components/buttons.dart';
// import 'package:le_coin_des_cuisiniers_app/controller/transactions_controller.dart';
// import 'package:le_coin_des_cuisiniers_app/models/transactions.dart';
// import 'package:le_coin_des_cuisiniers_app/views/base_layout.dart';
// import 'package:le_coin_des_cuisiniers_app/views/product/products_list.dart';
// import 'package:le_coin_des_cuisiniers_app/views/transactions/add_transactions.dart';
// import 'package:le_coin_des_cuisiniers_app/views/transactions/update_transaction.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

// class BillItems extends StatefulWidget {
//   final Transaction? transaction;

//   const BillItems({super.key, required this.transaction});

//   @override
//   State<BillItems> createState() => _BillItemsState();
// }

// class _BillItemsState extends State<BillItems> {
//   double? generalTotal;
//   @override
//   void initState() {
//     super.initState();
//     _calculateGeneralTotal();
//   }

//   void _calculateGeneralTotal() {
//     final transactionsController =
//         Provider.of<TransactionsController>(context, listen: false);
//     final total = transactionsController.transactionsList.fold<double>(
//         0.0, (sum, transaction) => sum + (transaction.totalPrice ?? 0.0));
//     setState(() {
//       generalTotal = total;
//     });
//   }

//   void _showDeleteConfirmationDialog(Transaction transaction) {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Confirmation'),
//           content: const Text(
//               'Veux-tu réellement enlever ce produit de la liste de vente?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//               },
//               child: const Text(
//                 'Non',
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();

//                 TransactionsController()
//                     .deleteTransaction(transaction, context);
//               },
//               child: const Text(
//                 'Oui',
//                 style: TextStyle(color: Color.fromARGB(255, 70, 103, 71)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Center(child: Text('Facture')),
//           backgroundColor: Colors.white,
//         ),
//         backgroundColor: Colors.white,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: const Icon(
//             Icons.print_outlined,
//             color: const Color.fromARGB(255, 70, 103, 71),
//           ),
//           backgroundColor: Colors.black,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 75.0),
//           child: Column(
//             children: [
//               MyButtons(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AddTransaction()));
//                 },
//                 text: 'Ajouter une nouvelle transaction',
//               ),
//               Consumer<TransactionsController>(
//                 builder: (context, value, child) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     _calculateGeneralTotal();
//                   });
//                   return SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: SingleChildScrollView(
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('Nom du Produit')),
//                           DataColumn(label: Text('Prix Unitaire')),
//                           DataColumn(label: Text('Quantité')),
//                           DataColumn(label: Text('Prix Total')),
//                           DataColumn(label: Text('Date de Vente')),
//                           DataColumn(label: Text('Action')),
//                         ],
//                         rows: value.transactionsList.map((transaction) {
//                           return DataRow(cells: [
//                             DataCell(Text('${transaction.productName}')),
//                             DataCell(Text('${transaction.unitPrice}')),
//                             DataCell(Text('${transaction.quantity}')),
//                             DataCell(Text('${transaction.totalPrice}')),
//                             DataCell(
//                               Text(
//                                 transaction.sellingDate != null
//                                     ? DateFormat('dd-MM-yyyy')
//                                         .format(transaction.sellingDate!)
//                                     : '',
//                               ),
//                             ),
//                             DataCell(
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   MouseRegion(
//                                     cursor: SystemMouseCursors.click,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 UpdateTransaction(
//                                               transId: transaction.transactionId!,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       child: const Icon(Icons.edit),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 20,
//                                   ),
//                                   MouseRegion(
//                                     cursor: SystemMouseCursors.click,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         _showDeleteConfirmationDialog(
//                                             transaction);
//                                       },
//                                       child: const Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 170.0),
//                     child: Text(
//                       'Total général',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 170.0),
//                     child: Text(
//                       '${generalTotal ?? 0.0} \$',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               MyButtons(
//                 onPressed: () {
//                   Provider.of<TransactionsController>(context, listen: false)
//                       .insertTheBillInTheDB(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AddTransaction()));
//                 },
//                 text: 'Enregister la facture',
//               ),
//             ],
//           ),
//         ),
//       );
//   }
// }
import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/buttons.dart';
import 'package:le_coin_des_cuisiniers_app/controller/transactions_controller.dart';
import 'package:le_coin_des_cuisiniers_app/models/transactions.dart';
import 'package:le_coin_des_cuisiniers_app/views/base_layout.dart';
import 'package:le_coin_des_cuisiniers_app/views/product/products_list.dart';
import 'package:le_coin_des_cuisiniers_app/views/transactions/add_transactions.dart';
import 'package:le_coin_des_cuisiniers_app/views/transactions/update_transaction.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BillItems extends StatefulWidget {
  final Transaction? transaction;

  const BillItems({super.key, required this.transaction});

  @override
  State<BillItems> createState() => _BillItemsState();
}

class _BillItemsState extends State<BillItems> {
  double? generalTotal;

  @override
  void initState() {
    super.initState();
    _calculateGeneralTotal();
  }

  void _calculateGeneralTotal() {
    final transactionsController =
        Provider.of<TransactionsController>(context, listen: false);
    final total = transactionsController.transactionsList.fold<double>(
        0.0, (sum, transaction) => sum + (transaction.totalPrice ?? 0.0));
    setState(() {
      generalTotal = total;
    });
  }

  void _showDeleteConfirmationDialog(Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Veux-tu réellement enlever ce produit de la liste de vente?'),
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
                Navigator.of(dialogContext).pop();
                TransactionsController()
                    .deleteTransaction(transaction, context);
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

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      initialIndex: 1,
      pages: [
        const ProductsList(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: MyButtons(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTransaction()));
                },
                text: 'Ajouter une nouvelle transaction',
              ),
            ),
            Consumer<TransactionsController>(
              builder: (context, value, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _calculateGeneralTotal();
                });
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nom du Produit')),
                        DataColumn(label: Text('Prix Unitaire')),
                        DataColumn(label: Text('Quantité')),
                        DataColumn(label: Text('Prix Total')),
                        DataColumn(label: Text('Date de Vente')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: value.transactionsList.map((transaction) {
                        return DataRow(cells: [
                          DataCell(Text('${transaction.productName}')),
                          DataCell(Text('${transaction.unitPrice}')),
                          DataCell(Text('${transaction.quantity}')),
                          DataCell(Text('${transaction.totalPrice}')),
                          DataCell(
                            Text(
                              transaction.sellingDate != null
                                  ? DateFormat('dd-MM-yyyy')
                                      .format(transaction.sellingDate!)
                                  : '',
                            ),
                          ),
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
                                          builder: (context) =>
                                              UpdateTransaction(
                                            transId: transaction.transactionId!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDeleteConfirmationDialog(
                                          transaction);
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
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 170.0),
                  child: Text(
                    'Total général',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 170.0),
                  child: Text(
                    '${generalTotal ?? 0.0} \$',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MyButtons(
              onPressed: () {
                Provider.of<TransactionsController>(context, listen: false)
                    .insertTheBillInTheDB(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTransaction()));
              },
              text: 'Enregister la facture',
            ),
          ],
        ),
      ],
    );
  }
}
