import 'package:dineout/pages/home_page.dart';
import 'package:dineout/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();

  Widget textfield({
    required String hintText,
    String? labelText,
    required TextEditingController controller,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void submitData(name, phoneNumber, aboutMe, birthDay) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        print(userProvider.email);

   

    print("Name: $name");
    print("Phone Number: $phoneNumber");
    print("About Me: $aboutMe");
    print("Birth Day: $birthDay");

    // update this in firestore databse by using email
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userProvider.email)
        .get();
      
        // now update this data in the firestore document

     if (querySnapshot.docs.isNotEmpty) {
    final documentSnapshot = querySnapshot.docs.first;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentSnapshot.id)
        .update({
      'name': name,
      'phoneNumber': phoneNumber,
      'aboutMe': aboutMe,
      'birthDay': birthDay,
    }).catchError((e) => print("Error writing document: $e"));
  }


  }


  @override
Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Color.fromARGB(255, 255, 79, 79),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text("Logout"),
              ),
              Icon(Icons.logout_sharp),
            ],
          ),
        )
      ],
    ),
    body: Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 200),
          painter: HeaderCurvedContainer(),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('profile.jpg'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textfield(
                    hintText: 'Enter your name',
                    labelText: 'Name',
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textfield(
                    hintText: 'Enter your phone number',
                    labelText: 'Phone Number',
                    controller: phoneNumberController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textfield(
                    hintText: 'Enter your about me',
                    labelText: 'About Me',
                    controller: aboutMeController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textfield(
                    hintText: 'Enter your birth day',
                    labelText: 'Birth Day',
                    controller: birthDayController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        submitData(nameController.text.trim(), phoneNumberController.text.trim(), aboutMeController.text.trim(), birthDayController.text.trim());
                      },
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 23,
                            color: Color.fromARGB(255, 236, 81, 81),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromARGB(255, 255, 79, 79);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -200)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
