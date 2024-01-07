// To parse this JSON data, do
//
//     final customersCreatePost = customersCreatePostFromJson(jsonString);

import 'dart:convert';

CustomersCreatePost customersCreatePostFromJson(String str) => CustomersCreatePost.fromJson(json.decode(str));

String customersCreatePostToJson(CustomersCreatePost data) => json.encode(data.toJson());

class CustomersCreatePost {
  String name;
  String email;
  String contact;
  String failExisting;
  String gstin;
  Notes notes;

  CustomersCreatePost({
    required this.name,
    required this.email,
    required this.contact,
    required this.failExisting,
    required this.gstin,
    required this.notes,
  });

  factory CustomersCreatePost.fromJson(Map<String, dynamic> json) => CustomersCreatePost(
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    contact: json["contact"] ?? "",
    failExisting: json["fail_existing"] ?? "",
    gstin: json["gstin"] ?? "",
    notes: Notes.fromJson(json["notes"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
    "fail_existing": failExisting,
    "gstin": gstin,
    "notes": notes.toJson(),
  };
}

class Notes {
  String notesKey1;
  String notesKey2;

  Notes({
    required this.notesKey1,
    required this.notesKey2,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    notesKey1: json["notes_key_1"],
    notesKey2: json["notes_key_2"],
  );

  Map<String, dynamic> toJson() => {
    "notes_key_1": notesKey1,
    "notes_key_2": notesKey2,
  };
}
