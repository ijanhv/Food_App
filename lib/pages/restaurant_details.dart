import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  List<String> tabTitles = ["Offers", "Reviews", "Menu", "Reviews"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          alignment: Alignment(0, 6),
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://b.zmtcdn.com/data/pictures/1/36331/db008b3e30efe28aad336044c6361ddc.jpg"),
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
                    elevation: 10.0,
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
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Le Cafe",
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
                              "₹ 1,100 for 2  ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Eurpoean, Bevarges,Continental, Italian ",
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
                child: Text("Le Cafe is a European oasis in Chembur. The menu at Le Cafe boasts favorites such as Braised Lamb Chops, Scottish Egg Affair, Classic Cubano Avocado & Bacon Tartine and many more.",
                style: TextStyle(
                  fontSize: 11
                ),
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
