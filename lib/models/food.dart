import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String? name;
  final String? description;
  final String? price;
  final String? image;


  Food({
    this.name,
    this.description,
    this.price,
    this.image


  });

  //  factory Food.fromSnapshot(QueryDocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //   return Food(
  //     name: data['name'],
  //     description: data['description'],
  //     price: data['price'].toDouble(),
  //     image: data['image'],
  //   );
  // }

}
