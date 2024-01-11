import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Dashboard.dart';
import 'customer_datamodel.dart';
import 'customer_homepage.dart';
import 'customer_provider_data.dart';
import 'items_rozarPay_api/Items_api_model.dart';
import 'items_rozarPay_api/item_class_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // FutureProvider<List<Item>?>(
        //   create: (context) => CustomersProvider().fetchData(),
        //   initialData: [], // You can set initial data based on your needs
        // ),
        ChangeNotifierProvider(
          create: (context) => CustomersProvider(),
          child: MyApp(),
        ),

        // ChangeNotifierProvider<ItemsDataProvider>(
        //   create: (_) => ItemsDataProvider(),
        //
        // )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Dashboard(),
      ),
    );
  }
}


