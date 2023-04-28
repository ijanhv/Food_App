import 'package:dineout/pages/home_page.dart';
import 'package:dineout/pages/update_profile.dart';
import 'package:dineout/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dineout/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget field({
    String? labelText,
    String? value, // Value coming from Firebase
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
        ),
        initialValue: value, // Set the initial value from Firebase
        enabled: false, // To prevent editing of the field
      ),
    );
  }

  late Future<QuerySnapshot<Map<String, dynamic>>> _fetchDataFuture;
  bool _dataFetched = false;

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchData(
      String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final email = userProvider.email;

    print(userProvider.email);

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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Color.fromARGB(255, 255, 79, 79),
                    onPrimary: Colors.white,
                  ),
                  child: Icon(Icons.logout_sharp),
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    Provider.of<UserProvider>(context, listen: false).setUserFullName("Guest");
                    Provider.of<UserProvider>(context, listen: false).setUserEmail("");
                  },
                ),
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
                  SingleChildScrollView(
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                            future: fetchData(email as String),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (snapshot.data != null) {
                                  // final phoneNumber =
                                  //     snapshot.data!.docs[0].get('phoneNumber');
                                  // final data = snapshot.data!.docs[0].data();
                                  final data = snapshot.data!.data();
                                  final name = data!['name'];
                                  final aboutMe = data['aboutMe'];
                                  final birthDay = data['birthDay'];
                                  final email = data['email'];
                                  final phoneNumber = data['phoneNumber'];

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: field(
                                          labelText: 'Email',
                                          value: email,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: field(
                                          labelText: 'Name',
                                          value: name,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: field(
                                          labelText: 'Phone Number',
                                          value: phoneNumber,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: field(
                                          labelText: 'About Me',
                                          value: aboutMe,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: field(
                                          labelText: 'BirthDay',
                                          value: birthDay,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }

                              return Text('No data found');
                            }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfilePage()));
                        },
                        child: Center(
                          child: Text(
                            "Update Profile",
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
