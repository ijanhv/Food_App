import 'package:flutter/material.dart';
import 'bag_page.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/bag_provider.dart';


class FoodDetailsPage extends StatefulWidget {
  final String? title;
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  
  const FoodDetailsPage({Key? key,  this.title, this.name, this.description, this.image, this.price}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantity = 0;
  List<String> bagItems = [];

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }
void _addToBag(BagProvider bagProvider) {
  for (int i = 0; i < quantity; i++) {
    bagProvider.addToBag(widget.name ?? 'Food Name', widget.price ?? 0.00);

  }
  quantity = 0;

    SnackBar snackBar = SnackBar(
      content: Text('Food item added to bag.'),
      duration: Duration(seconds: 1),
    );

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Success'),
    //       content: Text('Food item added to bag.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('OK'),

    //         ),
    //       ],
    //     );
    //   },
    // );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BagPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
              final bagProvider = Provider.of<BagProvider>(context);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Food Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
  widget.image?.toString() ?? '',
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.title ?? 'Food Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${widget.price?.toString() ?? '0.00'}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.description?.toString() ?? 'Food description',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementQuantity,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
            
                ),
                onPressed: quantity > 0 ? () => _addToBag(bagProvider) : null,
                child: Text('Add to Bag'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
