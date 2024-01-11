import 'package:api_flutter_rozarpay/items_rozarPay_api/items_create_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart%20';
import 'package:provider/provider.dart';

import 'Items_api_model.dart';
import 'item_class_provider.dart';

class ItemHomePage extends StatefulWidget {
  const ItemHomePage({super.key});

  @override
  State<ItemHomePage> createState() => _ItemHomePageState();
}

class _ItemHomePageState extends State<ItemHomePage> {

  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();
  TextEditingController updateAmountController = TextEditingController();
  TextEditingController updateCurrencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),

      body: FutureProvider<List<Item>?>(
        create: (_) => ItemsDataProvider().ItemsfetchData(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return null; // Return null in case of an error
        },
        initialData: null,
        child: Consumer<List<Item>?>(
          builder: (context, items, _) {
            if (items == null || items.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(items[index].name.toString()),
                      subtitle: Text(items[index].description.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showUpdateDialog(context, items[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),

                            onPressed: () async {
                              var itemsDataProvider = Provider.of<ItemsDataProvider>(context, listen: false);
                              await itemsDataProvider.deleteItem(items[index].id, context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemCreatePost()));
        },
        tooltip: 'Create Customer',
        child: Icon(Icons.add),
      ),
    );
  }


  void _showUpdateDialog(BuildContext context, Item currentItem) {
    updateNameController.text = currentItem.name ?? '';
    updateDescriptionController.text = currentItem.description ?? '';
    updateAmountController.text = currentItem.amount.toString() ?? '';
    updateCurrencyController.text = currentItem.currency ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Update User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: updateNameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: currentItem.name,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: updateDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: currentItem.description,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: updateAmountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: currentItem.amount.toString(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: updateCurrencyController,
                  decoration: InputDecoration(
                    labelText: 'Currency',
                    hintText: currentItem.currency,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _updateCustomer(context, currentItem.id.toString());
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateCustomer(BuildContext context, String customerId) async {
    final String updateName = updateNameController.text.trim();
    final String updateDesc = updateDescriptionController.text.trim();
    final String updateAmount = updateAmountController.text.trim();
    final String updateCurrency = updateCurrencyController.text.trim();

    if (updateName.isNotEmpty && updateDesc.isNotEmpty && updateAmount.isNotEmpty && updateCurrency.isNotEmpty ) {
      try {

        await Provider.of<ItemsDataProvider>(context, listen: false).itemupdateCustomer(customerId, updateName, updateDesc,updateAmount,updateCurrency);

        // Optionally, clear the text fields after successful update
        updateNameController.clear();
        updateDescriptionController.clear();
        updateAmountController.clear();
        updateAmountController.clear();
      } catch (e) {
        print('Error updating customer: $e');
        // Handle error
      }
    } else {
      // Display a message or alert about empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

}
