import 'dart:ffi';

class Restaurant {
  final String? name;
  final String? address;
  final String? cost;
  final String? cuisine;
  final String? image;
  final bool? isOpen;
  final String? closingTime;
  final String? rating;
  final String? id;
  final String? desc;
  final String? contact;
  final String? features;
  final String? food_appPay;
  final int?  discount;
  

  Restaurant({
    this.id,
    this.name,
    this.address,
    this.cost,
    this.cuisine,
    this.image,
    this.isOpen,
    this.closingTime,
    this.rating,
    this.desc,
    this.contact,
    this.features,
    this.food_appPay,
    this.discount,

  });
}
