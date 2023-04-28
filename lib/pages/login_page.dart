import 'package:dineout/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dineout/pages/register_page.dart';
import 'package:dineout/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  void _submit(email, password) async {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        print(email);
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
                email: email.trim(), password: password.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged In')),
        );

        // String? userId = userCredential.user?.uid;
        print(userCredential.user?.email);

        // Fetch user document from Firestore
        try {
          final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.size > 0) {
            final DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
            // Access the document data using documentSnapshot.data()
            print(documentSnapshot.data());

            String fullName = documentSnapshot.get('name');
            print(fullName);
            Provider.of<UserProvider>(context, listen: false)
                .setUserFullName(fullName);
            // set email
            Provider.of<UserProvider>(context, listen: false)
                .setUserEmail(email);
          } else {
            print("No document found for the provided email.");
          }
        } catch (e) {
          print("Error: $e");
        }

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Something went wrong!')),
        );
        print(e.message);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        title: Text(
          'Login / Signup',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Theme(
          data: ThemeData(
            primaryColor: Colors.black,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
      ),
      //body
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value) {
                    if (value?.isEmpty == true ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Enter a valid password!';
                    } else if (value!.length < 8) {
                      return 'Password must be of more than 8 characters';
                    }
      
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        // color: Colors.fromARGB(255, 202, 59, 15),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 245, 106, 64),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        onPressed: () => {
                              _submit(
                                  emailController.text, passwordController.text),
                            }
                        // color: Colors.orange,
                        ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        // primary: Color.fromARGB(255, 245, 106, 64),
                        primary: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 245, 106, 64),
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage())),
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(
                  "By signing up you accept to out Terms and Conditions",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
