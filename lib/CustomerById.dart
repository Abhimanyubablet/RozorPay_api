import 'dart:convert';

import 'package:api_flutter_rozarpay/customer_provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_datamodel.dart';
import 'package:http/http.dart' as http;

class CustomerById extends StatefulWidget {
  const CustomerById({super.key});

  @override
  State<CustomerById> createState() => _CustomerByIdState();
}

class _CustomerByIdState extends State<CustomerById> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider<List<Item>?>(
        create: (_) => CustomersProvider().getDataById(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return null;
        },
        initialData: null,
        child: Consumer<List<Item>?>(
          builder: (context, items, _) {
            if (items == null || items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Item currentItem = items[index];
                  return ListTile(
                    title: Text(currentItem.name.toString()),
                    subtitle: Text(currentItem.email.toString()),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }



}
