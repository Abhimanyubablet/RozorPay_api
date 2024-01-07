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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: FutureProvider<List<Item>?>(
        create: (_) => fetchData(),
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
                  return ListTile(
                    title: Text(items[index].name.toString()),
                    subtitle: Text(items[index].email.toString()),
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

  Future<List<Item>> fetchData() async {
    String username = 'rzp_test_spCetGguNd0T6X';
    String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/customers'),
      headers: {"Authorization": basicAuth},
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<dynamic> items = data['items'];
      var itemList = items.map((e) => Item.fromJson(e)).toList();
      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _handleFloatingActionButton(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerCrud()));
  }


}
