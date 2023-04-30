import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dineout/firebase_util.dart';
import 'package:dineout/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class RestaurantDetails extends StatefulWidget {
   final Restaurant restaurant;


  const RestaurantDetails({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  List<String> tabTitles = ["Offers", "Reviews", "Menu", "Reviews"];
    Restaurant? _restaurant; // Declare _restaurant variable here


  Future<void> _fetchRestaurant() async {
  try {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.restaurant.id)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      print('Document data: $data');

      setState(() {
        _restaurant = Restaurant(
          name: data['name']?.toString() ?? '',
          address: data['address']?.toString() ?? '',
          cost: data['cost']?.toString() ?? '0.0',
          cuisine: data['cuisine']?.toString() ?? '',
          image: data['image']?.toString() ?? '',
          isOpen: data['isOpen'] as bool? ?? false,
          closingTime: data['closingTime']?.toString() ?? '10 PM',
          rating: data['rating']?.toString() ?? '0.0',
          id: widget.restaurant.id,
          desc: data['desc']?.toString() ?? '',
          contact: data['contact']?.toString() ?? '',
          features: data['features'] ?? [],
          dineoutPay: data['dineoutPay']?.toString() ?? '',
        );
      });
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching restaurant: $e');
  }
}

 @override
  void initState() {
    super.initState();
    _fetchRestaurant();
  
  }

 

  @override
  Widget build(BuildContext context) {
    print("here is restaurant:");
    print(_restaurant?.address);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {

            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(

        child: Column(children: [
          Stack(
            alignment: Alignment(0, 6),
            children: [
              // add back button here
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.restaurant.image ??
                            ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              Container(
                child: Column(children: [                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      elevation: 5.0,
                      shadowColor: Color.fromARGB(255, 169, 169, 169),                      
                      // color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(tabTitles.length, (index) {
                                return Text(tabTitles[index]);
                              }),
                            ),
                            Divider(
                              color: Color.fromARGB(255, 216, 76, 76),
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                     widget.restaurant.name ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    )
                                    ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                

                                  // scrollDirection: Axis.horizontal,
                                  child: Text(
                                  
                                    widget.restaurant.address ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(children: [
                              Text(
                                "₹ ${widget.restaurant.cost} •  " ?? '',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                widget.restaurant.cuisine?.replaceAll('[', '')
                                                                      ?.replaceAll(
                                                                          ']',
                                                                          '') ??
                                                                  '', 
                                
                                style: TextStyle(
                                    color: Color.fromARGB(255, 104, 104, 104),
                                    fontSize: 12),
                              ),
                            ]),
                            const SizedBox(height: 15),
                            Row(children: [
                              Text(
                                widget.restaurant.isOpen == true
                                    ? "Open Now"
                                    : "Closed Now",
                                style: TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                              Text("• "),
                              Text(
                                "Closes at ${widget.restaurant.closingTime}" ?? '',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 104, 104, 104),
                                    fontSize: 12),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
          const SizedBox(height: 130),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Card(
              margin: EdgeInsets.all(10.0),
              elevation: 10.0,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        "Pay Bill",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Save extra 5% using PromoCash",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Card(
              margin: EdgeInsets.all(8.0),
              elevation: 10.0,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.dinner_dining_sharp),
                        Text(
                          "Reserve a Table",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 77, 75, 75)),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Card(
              margin: EdgeInsets.all(10.0),
              elevation: 10.0,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        "Stories",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Capture memories and be the first one to upload a story here",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ADD STORY",
                        
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red[400]
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
      
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Card(
              margin: EdgeInsets.all(8.0),
              elevation: 10.0,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        "About",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 20, 20, 20)),
                      ),
                      
                              
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(widget.restaurant.desc ?? '',
                  style: TextStyle(
                    fontSize: 11
                  ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        "Cuisines",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.cuisine?.replaceAll('[', '') ?.replaceAll(']','') ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              Padding(padding: 
              const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    "Average Cost",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),  
              ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.cost ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        "Features",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 20, 20, 20)),
                      ),
                      
                              
                    ],
                  ),
                ),
          Padding(
  padding: const EdgeInsets.all(5.0),
  child: GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: widget.restaurant.features != null ? widget.restaurant.features!.split(',').length : 0,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 4,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 1.0,
    ),
    itemBuilder: (context, index) {
      if (widget.restaurant.features == null) return SizedBox.shrink();

      final features = widget.restaurant.features!.replaceAll('[', '').replaceAll(']', '').split(',');
      if (index >= features.length) return SizedBox.shrink();

      final feature = features[index].trim();
      return Row(
        children: [
          Icon(Icons.check, color: Colors.green),
          SizedBox(width: 2.0),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      );
    },
  ),
)






                
                

                

              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
