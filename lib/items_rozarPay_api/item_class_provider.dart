import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;

import 'Items_api_model.dart';
import 'item_create_datamodel.dart';


class ItemsDataProvider with ChangeNotifier{

  List<ItemsCreatePostModel> _posts = [];
  List<ItemsCreatePostModel> get posts => _posts;



  Future<List<Item>> ItemsfetchData() async {
    String username = 'rzp_test_spCetGguNd0T6X';
    String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(Uri.parse('https://api.razorpay.com/v1/items'), headers: {
      "Authorization" :basicAuth
    });

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<dynamic> items = data['items'];
      var itemList = items.map((e) => Item.fromJson(e)).toList();
      return itemList;
      // return  RazorPayModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }

}


  Future<ItemsCreatePostModel> itemsCreatePost(ItemsCreatePostModel post, BuildContext context) async {
    try {
      String username = 'rzp_test_spCetGguNd0T6X';
      String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

      var postResponse = await http.post(
        Uri.parse("https://api.razorpay.com/v1/items"),
        body: jsonEncode(post), // Pass the actual instance to jsonEncode

        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      // Print the response for debugging
      print('Post Response Body: ${postResponse.body}');
      print('Post Response Status Code: ${postResponse.statusCode}');

      if (postResponse.statusCode >= 200 && postResponse.statusCode < 300) {
        final newPost = ItemsCreatePostModel.fromJson(jsonDecode(postResponse.body));
        _posts.add(newPost); // Add the new post to the list
        notifyListeners(); // Notify listeners about the change

        // Show a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Post created successfully'),
            duration: Duration(seconds: 2),
          ),
        );

        return newPost;
      } else {
        // Throw a more specific error with details
        throw Exception('Failed to create post. Status Code: ${postResponse.statusCode}, Body: ${postResponse.body}');
      }
    } catch (e) {
      // Print the error for debugging
      print('Error in createPost: $e');

      // Throw a more specific error with details
      throw Exception('Failed to create post: $e');
    }
  }

  List<Item> _items = [];
  List<Item> get item => _items;
   Future<void> deleteItem(String itemId, BuildContext context) async {
     String username = 'rzp_test_spCetGguNd0T6X';
     String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
     String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    try {
      var deleteResponse = await http.delete(
        Uri.parse("https://api.razorpay.com/v1/items/$itemId"),
        headers: {"Authorization" :basicAuth},
      );

      if (deleteResponse.statusCode == 200) {
        // Item successfully deleted
        _items.removeWhere((item) => item.id == itemId); // Remove the item from the list
        notifyListeners(); // Notify listeners about the change

        // Show a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item deleted successfully'),
            duration: Duration(seconds: 2), // You can adjust the duration as needed
          ),
        );
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('delete failed: $e');

    }
  }


  Future<Item> itemupdateCustomer(String itemId, String updateName, String updateDesc, String updateAmount,String updateCurrency) async {
    try {
      String username = 'rzp_test_spCetGguNd0T6X';
      String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      final response = await http.patch(
        Uri.parse('https://api.razorpay.com/v1/items/$itemId'),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": updateName,
          "description": updateDesc,
          "amount": int.parse(updateAmount),
          "currency": updateCurrency,

        }),
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Item updatedItem = Item.fromJson(data);
        // Notify listeners or update the state as needed
        Fluttertoast.showToast(
          msg: "Data updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.pink,

        );
        notifyListeners();
        return updatedItem;
      } else {
        throw Exception('Failed to update customer. Status Code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in updateCustomer: $e');
      throw Exception('Failed to update customer: $e');
    }
  }

  Future<List<Item>?> itemgetDataById() async {
    try {
      String username = 'rzp_test_spCetGguNd0T6X';
      String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

      final response = await http.get(Uri.parse('https://api.razorpay.com/v1/items/item_NMMVavdligOW0z'), headers: {
        "Authorization" :basicAuth
      });

      print(response);

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        List<Item> itemList = [Item.fromJson(data)];
        return itemList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error in itemgetDataById: $e');
      return null;
    }
  }



}

