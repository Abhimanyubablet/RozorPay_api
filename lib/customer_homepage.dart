import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'customer_crud.dart';
import 'customer_provider_data.dart';
import 'customer_datamodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerHomePage extends StatefulWidget {
  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),

      body: FutureProvider<List<Item>?>(
        create: (_) => CustomersProvider().fetchData(),
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
                      subtitle: Text(items[index].contact.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showUpdateDialog(context, items[index]);
                            },
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.delete),
                          //   onPressed: () {
                          //     // Handle delete action
                          //     // You can show a confirmation dialog and delete the item if confirmed.
                          //   },
                          // ),
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
          _handleFloatingActionButton(context);
        },
        tooltip: 'Create Customer',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Item currentItem) {
    nameController.text = currentItem.name ?? '';
    emailController.text = currentItem.email ?? '';
    contactController.text = currentItem.contact ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: currentItem.name,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: currentItem.email,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: 'Contact',
                  hintText: currentItem.contact,
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
        );
      },
    );
  }

  Future<void> _updateCustomer(BuildContext context, String customerId) async {
    final String newName = nameController.text.trim();
    final String newEmail = emailController.text.trim();
    final String newContact = contactController.text.trim();

    if (newName.isNotEmpty && newEmail.isNotEmpty && newContact.isNotEmpty ) {
      try {

        await Provider.of<CustomersProvider>(context, listen: false).updateCustomer(customerId, newName, newEmail,newContact,);

        // Optionally, clear the text fields after successful update
        nameController.clear();
        emailController.clear();
        contactController.clear();
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



  void _handleFloatingActionButton(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerCrud()));
  }
}
