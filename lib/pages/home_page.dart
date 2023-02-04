import 'package:carousel_slider/carousel_slider.dart';
import 'package:dineout/pages/restaurant_details.dart';
import 'package:dineout/widgets/drawer.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  int _selectedIndex = 0;
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
      backgroundColor: Colors.grey[200],
      body: Column(
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
                    const Text(
                      'Chembur, Central Suburbs',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Row(children: [

               
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  // child: SvgPicture.asset('assets/images/qrcode.svg')),
                  child: const Icon(Icons.qr_code_2_outlined,
                      color: Color.fromARGB(255, 95, 93, 93)),
                ),
                Builder(
                  builder: (context) {
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        // child: SvgPicture.asset('assets/images/qrcode.svg')),
                          child: IconButton(
                          icon: Icon(Icons.person,
                              color: Color.fromARGB(255, 95, 93, 93)),
                          onPressed: () => Scaffold.of(context).openDrawer()
                        ));
                  }
                ),
                 ],)
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
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Search Anything...',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(5),
                              // child: SvgPicture.asset(
                              //     'assets/images/search-icon.svg'),
                              child: const Icon(Icons.search),
                              width: 10,
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 30),
          //carousel

          // SliderScreen(),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://cdn.zoutons.com/images/originals/blog/offerbanner1312_1648621628.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://cdn.zoutons.com/images/originals/blog/3zomato_1636547645.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://cdn.zoutons.com/images/originals/blog/Zomato_coupon_hack_1645609954.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
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
                  children: const [
                    Text(
                      'Restaurants Near You',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    // GoogleFonts.lato(fontStyle: FontStyle.italic),
                    Text(
                      'VIEW ALL',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ]),
            ),
          ),

          CarouselSlider(
            items: [
              //1st Image of Slider
              InkWell(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantDetails()))
                },
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/7/h/t/p73265-15776215715e089843df11f.jpg?tr=tr:n-medium"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://assets.architecturaldigest.in/photos/6008216856e01e341bc35381/master/pass/Pa-Pa-Ya-BKC-Mumbai1-1366x768.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/9/h/q/p96974-1633587070615e8f7eb5782.jpg?w=400"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://im.whatshot.in/img/2020/Sep/11985-d-1601060953.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              // autoPlay: true,
              aspectRatio: 1 / 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
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
        ],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded,
                    color: Color.fromARGB(255, 95, 93, 93)),
                label: 'Home'),
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
