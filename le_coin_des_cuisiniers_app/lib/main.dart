import 'dart:io';
import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/controller/transactions_controller.dart';
import 'package:le_coin_des_cuisiniers_app/views/home_page.dart';
import 'package:le_coin_des_cuisiniers_app/views/product/products_list.dart';
import 'package:le_coin_des_cuisiniers_app/views/transactions/add_transactions.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void logMessage(String message) {
  final logFile = File('app_log.txt');
  logFile.writeAsStringSync('$message\n', mode: FileMode.append);
}

void main() async {
  logMessage('App initialization started.');
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize window manager.
    logMessage('Initializing window manager...');
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      logMessage('Setting window size and properties...');
      await windowManager.setMinimumSize(const Size(1200, 500));
      await windowManager.setSize(const Size(1200, 500));
      await windowManager.setResizable(true);
      logMessage('Window manager initialized successfully.');
    });

    // Initialize SQLite FFI.
    logMessage('Initializing SQLite FFI...');
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    logMessage('SQLite FFI initialized successfully.');

    runApp(const MyApp());
    logMessage('App started successfully.');
  } catch (e, stackTrace) {
    logMessage('Error during initialization: $e');
    logMessage('Stack trace: $stackTrace');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    logMessage('Building MyApp widget...');
    return ChangeNotifierProvider(
      create: (context) => TransactionsController(),
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
