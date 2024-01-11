// To parse this JSON data, do
//
//     final itemsCreatePostModel = itemsCreatePostModelFromJson(jsonString);

import 'dart:convert';

ItemsCreatePostModel itemsCreatePostModelFromJson(String str) => ItemsCreatePostModel.fromJson(json.decode(str));

String itemsCreatePostModelToJson(ItemsCreatePostModel data) => json.encode(data.toJson());

class ItemsCreatePostModel {
  String name;
  String description;
  int amount;
  String currency;

  ItemsCreatePostModel({
    required this.name,
    required this.description,
    required this.amount,
    required this.currency,
  });

  factory ItemsCreatePostModel.fromJson(Map<String, dynamic> json) => ItemsCreatePostModel(
    name: json["name"],
    description: json["description"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "amount": amount,
    "currency": currency,
  };
}
