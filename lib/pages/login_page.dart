import 'package:food_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app/pages/register_page.dart';
import 'package:food_app/provider/user_provider.dart';
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
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.food_bank_outlined, size: 50),
                     Text("hello",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  ), 
                  Text("food",
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 33, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                    ),
                  
                  ),
                  ],),
                ),
               
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 232, 231, 231),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                      labelText: 'E-Mail',
                      border: InputBorder.none,
                      // add color
                      ),
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
                  ),
                ),
                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //text input
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 232, 231, 231),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password',
                      border: InputBorder.none,
                      ),
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
               
                  Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // pink
                        Colors.pink.shade300,
                        Color.fromARGB(255, 245, 106, 64),
                        
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors
                          .transparent, // Set the button background color to transparent
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "SIGN IN",
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
                            },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(
                  "Dont have an account?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text("Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
