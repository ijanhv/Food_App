import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dineout/models/restaurant.dart';

class BillPage extends StatefulWidget {
  final Restaurant restaurant;

  const BillPage({super.key, required this.restaurant});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  double totalAmount = 0;
  double discountedAmount = 0;

  void calculateDiscountedAmount(String value) {
    setState(() {
      totalAmount = double.tryParse(value) ?? 0;
      discountedAmount =
          totalAmount - (totalAmount * (widget.restaurant.discount! / 100));
    });
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      calculateDiscountedAmount(textEditingController.text);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 84, 80),
        title: Text(
          "PAYING TO",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.restaurant.name.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                    widget.restaurant.address
                                            .toString()
                                            .substring(0, 50) +
                                        '...',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                alignment: Alignment.topRight,
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        widget.restaurant.image ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      
              // image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    children: [
                      Text(
                        "dineout",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 81, 81, 81),
                        ),
                      ),
                      Text(
                        "PAY",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 84, 80),
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
      
              Divider(color: Color.fromARGB(255, 235, 235, 235), thickness: 3),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 81, 81, 81),
                        ),
                      ),
                      SizedBox(width: 70),
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Enter Amount',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 170, 170, 170),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.green,
                      child: Icon(
                        Icons.percent,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${widget.restaurant.discount}% will be applied to this amount",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    discountedAmount.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 81, 81, 81),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                children: [
                  Text(
                    "You Save",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 81, 81, 81),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "₹${(totalAmount - discountedAmount).toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 81, 81, 81),
                    ),
                  ),
                ],
              ),
      
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 84, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Pay Bill ₹${discountedAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
