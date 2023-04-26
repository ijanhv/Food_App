import 'package:dineout/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // final User? user = Auth().currentUser;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null) {
      return;
    }
    if (isValid == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
    _formKey.currentState?.save();
  }

  final emailTextEditController = new TextEditingController();
  final fullNameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
    final FocusNode _fullNameFocus = FocusNode();
final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        title: Text(
          'Register / Signup',
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
      body: Padding(
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
                // onFieldSubmitted: (value) {
                //   //Validator
                // },
                validator: (value) {
                  if (value?.isEmpty == true ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                 controller: emailTextEditController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                       onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_fullNameFocus);
                      },
              ),

              //box styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) {
                  //Validator
                },
                 controller: fullNameTextEditController,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _fullNameFocus,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              //text input
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
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
                 autofocus: false,
                      controller: passwordTextEditController,
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordFocus,
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
                       onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _firebaseAuth
                              .createUserWithEmailAndPassword(
                                  email: emailTextEditController.text,
                                  password: passwordTextEditController.text)
                              .then((onValue) {
                            Firestore.instance
                                .collection('users')
                                .document(onValue.uid)
                                .setData({
                              'fullName': fullNameTextEditController.text,
                              
                            }).then((userInfoValue) {
                              Navigator.of(context).pushNamed(HomePage.tag);
                            });
                          }).catchError((onError) {
                            processError(onError);
                          });
                        }
                      },
                      // color: Colors.orange,
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
    );
  }
}
