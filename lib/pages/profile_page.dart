import 'package:food_app/pages/home_page.dart';
import 'package:food_app/pages/login_page.dart';
import 'package:food_app/pages/update_profile.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/services/auth.dart';

class ProfilePage extends StatefulWidget {
const ProfilePage({Key? key}) : super(key: key);

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
    String? email) async {
  if (email != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0];
    }
  }

  return null;
}
  

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final email = userProvider.email;
    print("59");
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
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserFullName("Guest");
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserEmail("");
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: [
        
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (userProvider.email == 'Guest')
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color.fromARGB(255, 255, 79, 79),
                        onPrimary: Colors.white,
                      ),
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
               
                  SingleChildScrollView(
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                            future: fetchData(email as String? ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              } else {
                                if (snapshot.data != null) {
                                  final data = snapshot.data!.data();
                                  final name = data!['name'];
                                  final address = data['adress'];
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
                                      Padding(padding: 
                                      const EdgeInsets.all(8.0),
                                      child: field(
                                        labelText: 'Address',
                                        value: address,
                                      ),
                                      ),
                                      
                                    ],
                                  );
                                } 
                                // else if (userProvider.email == 'Guest') {

                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      primary: Color.fromARGB(255, 255, 79, 79),
                                      onPrimary: Colors.white,
                                    ),
                                    child: Text('Login'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                  );
                                }
                              // }

                              // return Text('No data found');
                            }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      child: FutureBuilder<
                          DocumentSnapshot<Map<String, dynamic>>?>(
                        future: fetchData(email as String? ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            if (snapshot.data != null) {
                              final data = snapshot.data!.data();
                              final userData = data!;

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor:  Color.fromARGB(255, 255, 84, 22),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateProfilePage(userData: userData),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "Update Profile",
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white),
                                    ),
                                  ),
                                
                              );
                            }
                          }

                          return Center(child: Text('No data found'));
                        },
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
