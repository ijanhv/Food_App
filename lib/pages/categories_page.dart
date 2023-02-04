import 'package:flutter/material.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://wallpaperaccess.com/full/4883006.jpg"),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://b.zmtcdn.com/data/pictures/4/19310144/48b152726cfdefe779349566363ce28d.jpg",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Mitron",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hotel Jewel of Chembur, Chembur Suburbs",
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "₹ 1,500 for 2  ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Continental, Bevarges,Continental, Italian ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 104, 104, 104),
                                        fontSize: 12),
                                  ),
                                ]),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "Now Open ",
                                    style: TextStyle(fontSize: 12, color: Colors.blue),
                                  ),
                                  Text("• "),
                                  Text(
                                    "Closes at 11:30 PM",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 104, 104, 104),
                                        fontSize: 12),
                                  ),
                                ])
                            ]
                            ),
                        
                          ),
                        ],
                      ),
                      
                    ],
                  ),

                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/4/e/o/p43650-15471099535c370641083b7.jpg?tr=tr:n-large",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Butterfly High",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bandra Kurla Complex",
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "₹ 1,500 for 2  ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Continental, Bevarges,Continental, Italian ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 104, 104, 104),
                                        fontSize: 12),
                                  ),
                                ]),
                                const SizedBox(height: 10),
                                Row(children: [
                                  Text(
                                    "Now Open ",
                                    style: TextStyle(fontSize: 12, color: Colors.blue),
                                  ),
                                  Text("• "),
                                  Text(
                                    "Closes at 11:30 PM",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 104, 104, 104),
                                        fontSize: 12),
                                  ),
                                ])
                            ]
                            ),
                        
                          ),
                        ],
                      ),
                      
                    ],
                  ),

                ),
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
                icon: Icon(Icons.home_rounded,
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
