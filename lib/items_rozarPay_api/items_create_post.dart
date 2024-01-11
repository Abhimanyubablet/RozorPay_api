import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_by_id.dart';
import 'item_class_provider.dart';
import 'item_create_datamodel.dart';

class ItemCreatePost extends StatefulWidget {
  const ItemCreatePost({super.key});

  @override
  State<ItemCreatePost> createState() => _ItemCreatePostState();
}

class _ItemCreatePostState extends State<ItemCreatePost> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemsDataProvider>(create: (_) => ItemsDataProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Post List'),
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
              Consumer<ItemsDataProvider>(
                builder: (context, postProvider, _) {
                  return Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                      TextField(
                        controller: amountController,
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                      TextField(
                        controller: currencyController,
                        decoration: InputDecoration(labelText: 'Currency'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final newPost = ItemsCreatePostModel(
                            name: nameController.text,
                            description: descController.text,
                            amount: int.parse(amountController.text),
                            currency: currencyController.text,


                          );
                          await postProvider.itemsCreatePost(newPost, context);

                          // Clear text controllers after posting
                          nameController.clear();
                          descController.clear();
                          amountController.clear();
                          currencyController.clear();
                        },
                        child: Text('Add Post'),
                      ),


                    ],
                  );
                },
              ),
              Center(
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemById()));
                    },
                    child: Text('Customer By Id')),
              )

            ],
          ),
        ),
      ),
    );
  }
}
