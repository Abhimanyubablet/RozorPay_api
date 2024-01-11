import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Items_api_model.dart';
import 'item_class_provider.dart';

class ItemById extends StatefulWidget {
  const ItemById({super.key});

  @override
  State<ItemById> createState() => _ItemByIdState();
}

class _ItemByIdState extends State<ItemById> {
  @override
  Widget build(BuildContext context) {

    return Scaffold();
    // return Scaffold(
    //   body: FutureProvider<List<Item>?>(
    //     create: (_) => ItemsDataProvider().itemgetDataById,
    //     catchError: (_, error) {
    //       print('Error fetching data: $error');
    //       return null;
    //     },
    //     initialData: null,
    //     child: Consumer<List<Item>?>(
    //       builder: (context, items, _) {
    //         if (items == null || items.isEmpty) {
    //           return const Center(child: CircularProgressIndicator());
    //         } else {
    //           return ListView.builder(
    //             itemCount: items.length,
    //             itemBuilder: (context, index) {
    //               Item currentItem = items[index];
    //               return ListTile(
    //                 title: Text(currentItem.name.toString()),
    //                 subtitle: Text(currentItem.description.toString()),
    //               );
    //             },
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );

  }
}
