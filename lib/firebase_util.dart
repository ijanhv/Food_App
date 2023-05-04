import 'package:cloud_firestore/cloud_firestore.dart';

const food_items = [
  {
"name": "Cheeseburger",
"description": "Juicy beef patty topped with melted cheese, lettuce, tomato, onion, and pickles on a sesame seed bun.",
"price": 9.99
},

{
"name": "Margherita Pizza",
"description": "Thin crust pizza topped with fresh tomato sauce, mozzarella cheese, and basil.",
"price": 12.99
},

{
"name": "Chicken Caesar Salad",
"description": "Crisp romaine lettuce topped with grilled chicken, croutons, parmesan cheese, and Caesar dressing.",
"price": 8.99
},

{
"name": "Fish and Chips",
"description": "Crispy battered cod served with thick-cut fries and tartar sauce.",
"price": 14.99
},

{
"name": "Pad Thai",
"description": "Stir-fried rice noodles with shrimp, tofu, bean sprouts, and peanuts in a sweet and tangy sauce.",
"price": 10.99
},

{
"name": "BBQ Ribs",
"description": "Tender and smoky pork ribs slathered in barbecue sauce.",
"price": 16.99
},

{
"name": "Vegetable Stir Fry",
"description": "Assorted vegetables sautéed with garlic and ginger in a soy sauce and sesame oil dressing.",
"price": 9.99
},

{
"name": "Spaghetti Bolognese",
"description": "Spaghetti noodles tossed with a meaty tomato sauce and topped with grated parmesan cheese.",
"price": 11.99
},

{
"name": "Beef Tacos",
"description": "Soft corn tortillas filled with seasoned ground beef, lettuce, tomato, and shredded cheese.",
"price": 7.99
},

{
"name": "Sushi Roll",
"description": "Rice, seaweed, and various fillings rolled into bite-sized pieces and served with soy sauce and wasabi.",
"price": 14.99
},
];

void uploadJsonData() async {
   CollectionReference collection = FirebaseFirestore.instance.collection('food_items');
    food_items.forEach((foodData) {
    collection.add(foodData);
  });
}


