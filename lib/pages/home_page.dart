import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/pages/food_list.dart';
import 'package:food_app/widgets/bottomNavigation.dart';
import 'package:food_app/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:provider/provider.dart';


// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {   

  List<String> imageList = [
    "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png",
    "https://cdn.zoutons.com/images/originals/blog/offerbanner1312_1648621628.png",
    "https://cdn.zoutons.com/images/originals/blog/3zomato_1636547645.png",
    "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png",
  ];

  List<Map<String, String>> foodList = [
    {
      'title': 'Burger',
      'url':
          'https://us.123rf.com/450wm/hugolacasse/hugolacasse1806/hugolacasse180600023/104344433-vector-hamburger-clip-art-illustration.jpg?ver=6'
    },
    {
      'title':  'Pizza',
      'url':
          'https://img.freepik.com/free-vector/sticker-template-with-pizza-isolated_1308-62307.jpg?w=2000',

    },
    {
      'title': 'Pav Bhaji',
      'url':
          'https://www.vegrecipesofindia.com/wp-content/uploads/2021/04/pav-bhaji-1.jpg',
    }
  ];

  List<Map<String, dynamic>> offerImageList = [
    {
      'imageUrl':
          "https://www.savoringitaly.com/wp-content/uploads/2022/04/vegan-creamy-tomato-pasta-1.jpg",
      'imageTitle': "Creamy Tomato Pasta"
    },
    {
      'imageUrl':
          "https://img.taste.com.au/KQvIuV_Z/taste/2021/04/creamy-chicken-tetrazzini-170487-2.jpg",
      'imageTitle': "Chicken Pasta"
    },
    {
      'imageUrl':
          "https://www.spiceupthecurry.com/wp-content/uploads/2020/09/paneer-tikka-recipe-2.jpg",
      'imageTitle': "Panner Tikka"
    },
    {
      'imageUrl':
          "https://www.vegrecipesofindia.com/wp-content/uploads/2021/04/pav-bhaji-1.jpg",
      'imageTitle': "Pav Bhaji"
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

 


  

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    print("hi");
    print(userProvider.fullName);
    // _getLocationPermission();

    return Scaffold(

        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //app bar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(vertical: 5),
                        //   // child: SvgPicture.asset('assets/images/qrcode.svg')),
                        //   child: const Icon(Icons.qr_code_2_outlined,
                        //       color: Color.fromARGB(255, 95, 93, 93)),
                        // ),
                        
                        Container(
                          padding: const EdgeInsets.all(8),
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
                  border: Border.all(color: Colors.grey),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SearchPage(),
                              //   ),
                              // );
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
                                hintText: 'What would you like to buy?',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 15),
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
  items: foodList.map((item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(item['url'].toString()),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 4, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0), // Add space between image and title
              Text(
                item['title'].toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }).toList(),
  options: CarouselOptions(
    height: 50.0,
    autoPlay: true,
    autoPlayCurve: Curves.fastOutSlowIn,
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    viewportFraction: 1 / 6,
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
                          'Popular Foods',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             // CategoriesPage(title: 'All-in-One')),
                          //   );
                          // },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // CategoriesPage(title: 'All-in-One')),
                                        FoodListPage()),
                              );
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 247, 64, 64),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),

              CarouselSlider(
                items: offerImageList.map((imageUrl) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FoodDetailsPage(
                      //       title: imageUrl['imageTitle'],
                            
                      //     ),
                      //   ),
                      // );
                    
                    },
                    child: Card(
                      elevation: 0.0,
                      color: Colors.white,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(

                                    imageUrl['imageTitle'],
                                    style: TextStyle(
                                      
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text("4.9 (124 Reviews) ⭐⭐⭐⭐⭐"),
                                ],
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
                  // autoPlay: true,
                  aspectRatio: 1 / 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  // enableInfiniteScroll: true,
                  viewportFraction: 1 /2,
                ),
              ),

              

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Best Foods",
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
        bottomNavigationBar: BottomNavbar());
  }
}
