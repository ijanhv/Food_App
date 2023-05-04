import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/bag_provider.dart';
import 'package:food_app/provider/user_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final bagProvider = Provider.of<BagProvider>(context);
        final userProvider = Provider.of<UserProvider>(context);

    final bagItems = bagProvider.bagItems;

    double totalPrice = 0.0;

    // Calculate the total price
    for (final item in bagItems) {
      totalPrice += item.price;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Checkout'),
      ),
      body: ListView.builder(
        itemCount: bagItems.length,
        itemBuilder: (context, index) {
          final item = bagItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Quantity: 1'),
            trailing: Text('Price: ${item.price}'),
          );
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Price:  ${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
           
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                
                              width: MediaQuery.of(context).size.width,

                child: ElevatedButton(
                  // color
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    // Add your checkout logic here
                  },
                  child: Text('Pay Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
