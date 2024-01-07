// To parse this JSON data, do
//
//     final customers = customersFromJson(jsonString);

// import 'dart:convert';
//
// Customers customersFromJson(String str) => Customers.fromJson(json.decode(str));
//
// String customersToJson(Customers data) => json.encode(data.toJson());
//
// class Customers {
//   String ?entity;
//   int ?count;
//   List<Item> ?items;
//
//   Customers({
//      this.entity,
//      this.count,
//      this.items,
//   });
//
//   factory Customers.fromJson(Map<String, dynamic> json) => Customers(
//     entity: json["entity"],
//     count: json["count"],
//     items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "entity": entity,
//     "count": count,
//     "items": List<dynamic>.from(items!.map((x) => x.toJson())),
//   };
// }
//
// class Item {
//   String ?id;
//   String ?entity;
//   String ?name;
//   String ?email;
//   String ?contact;
//   String ?gstin;
//   Notes ?notes;
//   // int? createdAt;
//
//   Item({
//      this.id,
//      this.entity,
//      this.name,
//      this.email,
//      this.contact,
//      this.gstin,
//      this.notes,
//     // required this.createdAt,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: json["id"],
//     entity: json["entity"],
//     name: json["name"],
//     email: json["email"],
//     contact: json["contact"],
//     gstin: json["gstin"],
//     notes: Notes.fromJson(json["notes"]),
//     // createdAt: json["created_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "entity": entity,
//     "name": name,
//     "email": email,
//     "contact": contact,
//     "gstin": gstin,
//     "notes": notes?.toJson(),
//     // "created_at": createdAt,
//   };
// }
//
// class Notes {
//   String notesKey1;
//   String notesKey2;
//
//   Notes({
//     required this.notesKey1,
//     required this.notesKey2,
//   });
//
//   factory Notes.fromJson(Map<String, dynamic> json) => Notes(
//     notesKey1: json["notes_key_1"],
//     notesKey2: json["notes_key_2"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "notes_key_1": notesKey1,
//     "notes_key_2": notesKey2,
//   };
// }




// To parse this JSON data, do
//
//     final razorPayCustomerModel = razorPayCustomerModelFromJson(jsonString);

import 'dart:convert';

Customers razorPayCustomerModelFromJson(String str) => Customers.fromJson(json.decode(str));

String razorPayCustomerModelToJson(Customers data) => json.encode(data.toJson());

class Customers {
  String? entity;
  int? count;
  List<Item>? items;

  Customers({
    this.entity,
    this.count,
    this.items,
  });

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
    entity: json["entity"],
    count: json["count"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "entity": entity,
    "count": count,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? id;
  Entity? entity;
  String? name;
  String? email;
  String? contact;
  String? gstin;
  dynamic notes;
  // int? createdAt;

  Item({
    this.id,
    this.entity,
    this.name,
    this.email,
    this.contact,
    this.gstin,
    this.notes,
    // this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    entity: entityValues.map[json["entity"]]!,
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    notes: json["notes"],
    // createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entityValues.reverse[entity],
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "notes": notes,
    // "created_at": createdAt,
  };
}

enum Entity {
  CUSTOMER
}

final entityValues = EnumValues({
  "customer": Entity.CUSTOMER
});

class NotesClass {
  String? notesKey1;
  String? notesKey2;

  NotesClass({
    this.notesKey1,
    this.notesKey2,
  });

  factory NotesClass.fromJson(Map<String, dynamic> json) => NotesClass(
    notesKey1: json["notes_key_1"],
    notesKey2: json["notes_key_2"],
  );

  Map<String, dynamic> toJson() => {
    "notes_key_1": notesKey1,
    "notes_key_2": notesKey2,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}