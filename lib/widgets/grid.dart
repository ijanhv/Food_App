import 'package:dineout/pages/categories_page.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({Key? key}) : super(key: key);

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
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
      'image': 'https://sukhis.com/app/uploads/2022/05/image2-3.jpg',
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
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 300, // Set a fixed height for the container
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            final imageUrl = imageUrls[index]['image'];
            final title = imageUrls[index]['title'];
            
            return Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Tapped on $title');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesPage(
                              title: title,
                            ),
                          ),
                        );
                      },
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title!,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
