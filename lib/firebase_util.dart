import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const restaurants = [
   {
  "name": "Yauatcha Mumbai",
  "desc": "Yauatcha is a Michelin-starred Chinese dim sum tea house offering a unique dining experience. It serves a wide range of dim sum delicacies, along with a variety of teas and signature cocktails.",
  "cuisine": ["Chinese", "Dim Sum"],
  "cost": "Rs 2500 for 2",
  "type": ["Fine Dining"],
  "address": "Raheja Tower, Bandra Kurla Complex, Bandra East, Mumbai",
  "features": ["Wifi", "Private Dining Area", "Full Bar Available", "Valet Parking"],
  "rating": "4.7",
  "contact": "022 2644 8888",
  "dineoutPay": "Yes",
  "image": "https://www.yauatcha.com/media/kvsliders/3n1cn/yauatcha-india"
},
{
  "name": "Masala Library by Jiggs Kalra",
  "desc": "Masala Library is a fine dining restaurant known for its innovative and modern take on Indian cuisine. It offers a culinary journey through various regions of India, presenting dishes with unique flavors and artistic presentation.",
  "cuisine": ["Indian", "Progressive"],
  "cost": "Rs 3000 for 2",
  "type": ["Fine Dining"],
  "address": "Ground Floor, First International Financial Centre, Bandra Kurla Complex, Bandra East, Mumbai",
  "features": ["Wifi", "Full Bar Available", "Private Dining Area", "Valet Parking"],
  "rating": "4.8",
  "contact": "022 6642 4142",
  "dineoutPay": "Yes",
  "image": "https://www.masalalibrary.com/images/ML_hero5.jpg"
},
{
  "name": "Bastian",
  "desc": "Bastian is a trendy seafood restaurant known for its fresh and flavorful seafood dishes. It offers a variety of seafood options, including lobsters, crabs, prawns, and fish, prepared with creative twists and delicious sauces.",
  "cuisine": ["Seafood"],
  "cost": "Rs 2500 for 2",
  "type": ["Casual Dining"],
  "address": "B/2, New Kamal Building, Opposite National College, Linking Road, Bandra West, Mumbai",
  "features": ["Wifi", "Full Bar Available", "Valet Parking", "Outdoor Seating"],
  "rating": "4.7",
  "contact": "022 2642 0145",
  "dineoutPay": "Yes",
  "image": "https://www.bastian.in/images/hero.jpg"
},

];

void uploadJsonData() async {
   CollectionReference collection = FirebaseFirestore.instance.collection('restaurants');
    restaurants.forEach((restaurantData) {
    collection.add(restaurantData);
  });
}


