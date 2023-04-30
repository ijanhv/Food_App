import 'dart:async';
import 'dart:math';
import 'package:dineout/pages/restaurant_details.dart';
import 'package:flutter/material.dart';
import 'package:dineout/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home'),
    Text('Index 1: Search'),
    Text('Index 2: Events'),
    Text('Index 3: Blog')
  ];

  List<Restaurant> _restaurants = [];

  Future<List<Restaurant>> _fetchRestaurants() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();

    final List<Restaurant> restaurants = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;


      return Restaurant(
        name: data['name']?.toString() ?? '',
        address: data['address']?.toString() ?? '',
        cost: data['cost']?.toString() ?? '0.0',
        cuisine: data['cuisine']?.toString() ?? '',
        image: data['image']?.toString() ?? '',
        isOpen: data['isOpen'] as bool? ?? false,
        closingTime: data['closingTime']?.toString() ?? '10 PM',
        rating: data['rating']?.toString() ?? '0.0',
        desc: data['desc']?.toString() ?? '',
        contact: data['contact']?.toString() ?? '',
        features: data['features']?.toString() ?? '',
        dineoutPay: data['dineoutPay']?.toString() ?? '',

        id: doc.id,
      );
    }).toList();

    return restaurants;
  }

  @override
  void initState() {
    super.initState();
    _fetchRestaurants().then((restaurants) {
      setState(() {
        _restaurants = restaurants;
      });
    });
  }

 void _onCardTapped(Restaurant restaurant) {
    print(restaurant.name);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetails(restaurant: restaurant),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_restaurants);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        actions: [
          
          
          IconButton(
            icon: const Icon(Icons.search,
              ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
               Container(
              height: 250,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/ea/68/bf/ea68bf1f0e3dea295897865063cee69d.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        const Text("All-in-one",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 40,
                                fontWeight: FontWeight.w500)),
                        Text("23 Restaurants",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
              FutureBuilder<List<Restaurant>>(
                future: _fetchRestaurants(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('Error fetching data'),
                    );
                  } else {
                    final restaurants = snapshot.data;
                    //  get the id of document please give code

                    print('snapshot ');
                    print(snapshot.data?[0].id);

                     

                    // print("restaurants $restaurants");
                    return ListView(
                  
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: restaurants
                                ?.map((restaurant) => GestureDetector(
                                  onTap: () => _onCardTapped(restaurant),
                                  child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0),
                                          child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        child: Image.network(
                                                          restaurant.image
                                                              .toString(),
                                                          height: 140,
                                                          width: double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(
                                                          10.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                
                                                            children: [
                                                              Text(
                                                                restaurant.name
                                                                    as String,
                                                                textAlign:
                                                                    TextAlign.left,
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 26,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                   Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber[500],
                                                                size: 20,
                                                              ),
                                                              Text(
                                                                restaurant.rating
                                                                    .toString(),
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                                ],
                                                              )
                                                             
                                                            ],
                                
                                                            // display rating in the form of stars
                                                          ),
                                                          const SizedBox(
                                                              height: 15),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                restaurant.address
                                                                        ?.toString()
                                                                        .substring(
                                                                            0,
                                                                            min(40,
                                                                                restaurant.address.toString().length)) ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                                textAlign:
                                                                    TextAlign.left,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(children: [
                                                            Text(
                                                              "₹ ${restaurant.cost}",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              restaurant.cuisine
                                                                      ?.replaceAll(
                                                                          '[', '')
                                                                      ?.replaceAll(
                                                                          ']',
                                                                          '') ??
                                                                  '',
                                                              style: TextStyle(
                                                                color:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        104,
                                                                        104,
                                                                        104),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ]),
                                                          const SizedBox(
                                                              height: 10),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                ))
                                .toList() ??
                            [],
                      
                    );
                  }
                },
              ),
                ]
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: Color.fromARGB(255, 95, 93, 93),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    color: Color.fromARGB(255, 173, 170, 170)),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                  color: Color.fromARGB(255, 173, 170, 170),
                ),
                label: 'Events'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.messenger_outline_sharp,
                  color: Color.fromARGB(255, 173, 170, 170),
                ),
                label: 'Blog'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 247, 64, 64),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
