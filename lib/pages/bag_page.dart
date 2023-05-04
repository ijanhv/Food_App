import 'package:food_app/pages/checkout_page.dart';
import 'package:food_app/pages/food_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/bag_provider.dart';

class BagPage extends StatefulWidget {
  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  Widget build(BuildContext context) {
    final bagProvider = Provider.of<BagProvider>(context);
    final bagItems = bagProvider.bagItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Bag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bagItems.length,
              itemBuilder: (context, index) {
                final item = bagItems[index];
                return ListTile(
                  title: Text(item.name ?? ''),
                  subtitle: Text('Quantity: ${item.price ?? ''}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Call the removeItem method of the BagProvider
                      bagProvider.removeFromBag(item.name ?? '');
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
              
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodListPage()),
                  ),
                  child: Text('Add More Items'),
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                            width: MediaQuery.of(context).size.width,
          
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Checkout'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
