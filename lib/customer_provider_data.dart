import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;

import 'customer_createPost_datamodel.dart';
import 'customer_datamodel.dart';

class CustomersProvider extends ChangeNotifier{
  List<CustomersCreatePost> _posts = [];
  List<CustomersCreatePost> get posts => _posts;




// Future<RazorPayModel> fetchData() async {
  Future<List<Item>> fetchData() async {
    String username = 'rzp_test_spCetGguNd0T6X';
    String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(Uri.parse('https://api.razorpay.com/v1/customers'), headers: {
      "Authorization" :basicAuth
    });

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<dynamic> items = data['items'];
      var itemList = items.map((e) => Item.fromJson(e)).toList();
      notifyListeners();
      return itemList;
      // return  RazorPayModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }




// Modify your createPost function


  Future<CustomersCreatePost> createPost(CustomersCreatePost post, BuildContext context) async {
    try {
      String username = 'rzp_test_spCetGguNd0T6X';
      String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

      var postResponse = await http.post(
        Uri.parse("https://api.razorpay.com/v1/customers"),
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
        final newPost = CustomersCreatePost.fromJson(jsonDecode(postResponse.body));
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



  Future<Item> updateCustomer(String customerId, String newName, String newEmail, String newContact) async {
    try {
      String username = 'rzp_test_spCetGguNd0T6X';
      String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      final response = await http.put(
        Uri.parse('https://api.razorpay.com/v1/customers/$customerId'),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": newName,
          "email": newEmail,
          "contact": newContact,
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



  Future<List<Item>> getDataById() async {
    String username = 'rzp_test_spCetGguNd0T6X';
    String password = 'z1ibOqW8JOo5sjDpqQ7bR3RL';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.get(Uri.parse('https://api.razorpay.com/v1/customers/cust_NLme5SjRK0OV16'), headers: {
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
  }


}
