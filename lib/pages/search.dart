import 'package:dineout/pages/restaurant_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dineout/models/restaurant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  List<Restaurant> _restaurants = [];
  List<Restaurant> filteredRestaurants = [];

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

  void filterSearchResults(String query) {
    List<Restaurant> searchList = _restaurants.where((restaurant) {
      return restaurant.name.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredRestaurants = searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 79, 79),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search Anything...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              prefixIcon: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.search),
                width: 10,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RestaurantDetails(restaurant: restaurant);
                    }));
                  },
                  child: Card(
                    elevation: 1.0,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(restaurant.name ?? ''),
                      subtitle: Text(restaurant.address ?? ''),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
