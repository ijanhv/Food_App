import 'package:carousel_slider/carousel_slider.dart';
import 'package:dineout/pages/categories_page.dart';
import 'package:dineout/pages/discount_page.dart';
import 'package:dineout/pages/search.dart';
import 'package:dineout/widgets/bottomNavigation.dart';
import 'package:dineout/widgets/drawer.dart';
import 'package:dineout/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:dineout/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
 

  List<Map<String, dynamic>> carouselData = [
    {
      'discount': '30',
      'color': Colors.green,
    },
    {
      'discount': '20',
      'color': Colors.purple,
    },
    {
      'discount': '15',
      'color': Colors.blue,
    },
    {
      'discount': '5',
      'color': Colors.red,
    },
  ];

  List<String> imageList = [
    "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png",
    "https://cdn.zoutons.com/images/originals/blog/offerbanner1312_1648621628.png",
    "https://cdn.zoutons.com/images/originals/blog/3zomato_1636547645.png",
    "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png",
  ];

  List<Map<String, dynamic>> offerImageList = [
    {
      'imageUrl':
          "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/7/h/t/p73265-15776215715e089843df11f.jpg?tr=tr:n-medium",
      'imageTitle': "Episode One"
    },
    {
      'imageUrl':
          "https://assets.architecturaldigest.in/photos/6008216856e01e341bc35381/master/pass/Pa-Pa-Ya-BKC-Mumbai1-1366x768.jpg",
      'imageTitle': "Pa Pa Ya"
    },
    {
      'imageUrl':
          "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/9/h/q/p96974-1633587070615e8f7eb5782.jpg?w=400",
      'imageTitle': "Blah"
    },
    {
      'imageUrl':
          "https://www.socialoffline.in/ChemburSocial/img/chembur-social-06.jpg",
      'imageTitle': "Chembur Social"
    }
  ];

  List<Map<String, String>> imageUrls = [
    {
      'image':
          'https://www.tastingtable.com/img/gallery/20-italian-dishes-you-need-to-try-at-least-once/l-intro-1643403830.jpg',
      'title': 'Italian',
    },
    {
      'image':
          'https://www.daysoftheyear.com/wp-content/uploads/national-fast-food-day.jpg',
      'title': 'Fast Food',
    },
    {
      'image': 'https://m.recipes.timesofindia.com/photo/96590900/96590900.jpg',
      'title': 'Indian',
    },
    {
      'image':
          'https://d1ralsognjng37.cloudfront.net/81b42081-1378-4f4a-8470-454c82df565a.jpeg',
      'title': 'Chinese',
    }
  ];



  void _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
    } else if (permission == LocationPermission.deniedForever) {
      // Handle denied permission forever
    } else {
      // Permission granted, proceed to get the location
      _getCurrentLocation();
    }
  }

  Future<List<Placemark>> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    // Do something with the latitude and longitude
    print('Latitude: $latitude, Longitude: $longitude');

    List<Placemark> placemarks = await placemarkFromCoordinates(19.05, 72.917);
    // print(placemarks);

    return placemarks;
  }

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    print("hi");
    print(userProvider.fullName);
    // _getLocationPermission();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            //app bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FutureBuilder<List<Placemark>>(
                        future: _getCurrentLocation(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            List<Placemark> placemarks = snapshot.data ?? [];
                            String sublocality =
                                placemarks[0].subLocality ?? '';
                            String locality = placemarks[0].locality ?? '';
                            return Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    color: Color.fromARGB(255, 95, 93, 93)),
                                Text(
                                  sublocality + ', ' + locality,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            );
                          } else {
                            return Text('No data available');
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        // child: SvgPicture.asset('assets/images/qrcode.svg')),
                        child: const Icon(Icons.qr_code_2_outlined,
                            color: Color.fromARGB(255, 95, 93, 93)),
                      ),
                      Builder(builder: (context) {
                        return Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            // child: SvgPicture.asset('assets/images/qrcode.svg')),
                            child: IconButton(
                                icon: Icon(Icons.person,
                                    color: Color.fromARGB(255, 95, 93, 93)),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer()));
                      }),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        // put text
                        child: Text(
                          userProvider.fullName ?? 'Guest',
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 95, 93, 93)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            //search box
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black38,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            print('search');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ),
                            );
                          },
                          child: TextField(
                            enabled: false,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search Anything...',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(5),
                                child: Icon(Icons.search),
                                width: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            //carousel

            CarouselSlider(
              items: imageList.map((imageUrl) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 140.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),

            const SizedBox(height: 20),

            //3 buttons
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Restaurants Near You',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoriesPage(title: 'All-in-One')),
                          );
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 247, 64, 64),
                          ),
                        ),
                      )
                    ]),
              ),
            ),

            CarouselSlider(
              items: offerImageList.map((imageUrl) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              imageUrl['imageTitle'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                // autoPlay: true,
                aspectRatio: 1 / 1,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 1.5 / 2,
              ),
            ),

            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Best Offers',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),

            CarouselSlider(
              items: carouselData.map((item) {
                return InkWell(
                  onTap: () {
                    print('offer ${item['discount']}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiscountPage(discount: num.parse(item['discount']),),
                        // builder: (context) => CategoriesPage(discount: num.parse(item['discount']))
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.7, // Reduce width to 70% of the screen width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: item['color'],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.7, // Reduce width to 70% of the screen width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: item['color'].withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment
                                .centerLeft, // Align the text to the left
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FLAT',
                                  style: TextStyle(
                                    backgroundColor: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: item['color'],
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        5.0), // Add some space between the text and the bottom border
                                Text(
                                  item['discount'] + '%',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        5.0), // Add some space between the text and the bottom border
                                Text(
                                  'Instant Discount',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 150.0,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1 / 3,
              ),
            ),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Curated Collections",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                PhotoGrid()
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavbar()
    );
  }
}
