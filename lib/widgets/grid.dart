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
          'https://www.eatthis.com/wp-content/uploads/sites/4/2021/09/grilled-chicken.jpg?quality=82&strip=1',
      'title': 'Grilled Chicken',
    },
    {
      'image':
          'https://static.toiimg.com/thumb/55369113.cms?width=1200&height=900',
      'title': 'Lasagna',
    },
    {
      'image': 'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/03/instant-pot-dal-rice-recipe.jpg',
      'title': 'Dal Rice',
    },
    {
      'image':
          'https://www.thespruceeats.com/thmb/UnVh_-znw7ikMUciZIx5sNqBtTU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/steamed-momos-wontons-1957616-hero-01-1c59e22bad0347daa8f0dfe12894bc3c.jpg',
      'title': 'Momos',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 800, // Set a fixed height for the container
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CategoriesPage(
                        //       title: title,
                        //     ),
                        //   ),
                        // );
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
