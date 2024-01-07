import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_createPost_datamodel.dart';
import 'customer_datamodel.dart';
import 'customer_provider_data.dart';

Entity? entityInstance;

class CustomerCrud extends StatefulWidget {
  const CustomerCrud({Key? key}) : super(key: key);

  @override
  State<CustomerCrud> createState() => _CustomerCrudState();
}

class _CustomerCrudState extends State<CustomerCrud> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomersProvider>(create: (_) => CustomersProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create, Update, Delete List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a new post:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Consumer<CustomersProvider>(
                builder: (context, postProvider, _) {
                  return Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: contactController,
                        decoration: InputDecoration(labelText: 'Contact'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {

                          final newPost = Customers(
                            entity: '',
                            count: 0,
                            items: [
                              Item(
                                id: '', // You might need to generate a unique ID
                                entity: entityInstance,
                                name: nameController.text,
                                email: emailController.text,
                                contact: contactController.text,
                                gstin: "12ABCDE2356F7GH",
                                notes: Notes(
                                  notesKey1: "Tea, Earl Grey, Hot",
                                  notesKey2: "Tea, Earl Grey… decaf.",
                                ),
                              ),
                            ],
                          );
                          await postProvider.createPost(newPost, context);

                          // Clear text controllers after posting
                          nameController.clear();
                          emailController.clear();
                          contactController.clear();
                        },
                        child: Text('Add Post'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
