import 'package:dineout/pages/home_page.dart';
import 'package:dineout/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditController =
      TextEditingController();
  final TextEditingController _fullNameTextEditController =
      TextEditingController();
  final TextEditingController _passwordTextEditController =
      TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isLoading = false;


void _submit(email, password, fullName) async {
  final isValid = _formKey.currentState?.validate();
  if (isValid != null && isValid) {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'id': userCredential.user?.uid,
        'name': fullName,
        'email': email,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered')),
      ).closed.then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Something went wrong!')),
      );
      print(e.message);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}







  @override
  void dispose() {
    _emailTextEditController.dispose();
    _fullNameTextEditController.dispose();
    _passwordTextEditController.dispose();
    _emailFocus.dispose();
    _fullNameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

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
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
      ),
      //body
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextEditController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              validator: (value) {
                if (value?.isEmpty == true ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)) {
                  return 'Enter a valid email!';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_fullNameFocus);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
              controller: _fullNameTextEditController,
              autofocus: false,
              textInputAction: TextInputAction.next,
              focusNode: _fullNameFocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordTextEditController,
              autofocus: false,
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocus,
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Enter a valid password!';
                } else if (value!.length < 8) {
                  return 'Password must be more than 8 characters';
                }
                return null;
              },
              // onFieldSubmitted: (_) {
              //   _submit;
              // },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Container(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 245, 106, 64),
                  ),
                  onPressed: () => _submit(
                  _emailTextEditController.text,
                  _passwordTextEditController.text,
                  _fullNameTextEditController.text,
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
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(
              "By signing up, you accept our Terms and Conditions",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
  }
}