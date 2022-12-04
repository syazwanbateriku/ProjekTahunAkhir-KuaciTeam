import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_akhir/ProfileScreen.dart';
import 'package:projek_akhir/color_utils.dart';
import 'package:projek_akhir/reusable_widget.dart';
import 'package:projek_akhir/helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Service service = Service();
  TextEditingController _FirstNameTextController = TextEditingController();
  TextEditingController _LastNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(icon: Icon(Icons.person),
                        labelText: 'First Name *',),
                      controller: _FirstNameTextController,
                      validator:(value) {
                        if (value == null || value.isEmpty) {
                          return 'Please donot leave blank';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(icon: Icon(Icons.person),
                        labelText: 'Last Name *',),
                      controller: _LastNameTextController,
                      validator:(value) {
                        if (value == null || value.isEmpty) {
                          return 'Please donot leave blank';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(icon: Icon(Icons.email),
                        labelText: 'Email ID *',),
                      controller: _emailTextController,
                      validator:(value) {
                        if (value == null || value.isEmpty) {
                          return 'Please donot leave blank';
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(icon: Icon(Icons.lock),
                        labelText: 'Password Name *',),
                      controller: _passwordTextController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                         if (value != null && value.length < 7) {
                          return 'Enter min. 7 characters';
                            }else{
                           return null;
                        }
                      }
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          backgroundColor: Colors.green.withOpacity(0.5)),
                        onPressed: () async{
                          if(_emailTextController.text.isNotEmpty && _passwordTextController.text.isNotEmpty)
                          {
                            var email_user = _emailTextController.text;
                            await service.createUser(_emailTextController.text, _passwordTextController.text, context);
                          await FirebaseFirestore.instance.collection("users").doc(email_user).set
                            ({
                            'firstname': _FirstNameTextController.text,
                            'lastname': _LastNameTextController.text,
                            await 'uid': user.uid
                          }).then((value) => popup());

                              // .then((value) => popup());
                            // await FirebaseFirestore.instance.collection("users").add({
                            //   'firstname': _FirstNameTextController.text,
                            //   'lastname':  _LastNameTextController.text,

                            // }).then((value) async=> await service.createUser(_emailTextController.text, _passwordTextController.text, context) ).then((value) => popup());
                            // service.createUser(_emailTextController.text, _passwordTextController.text, context);/
                          }else {
                            service.error(context, "Field tidak boleh kosong");
                          }
                        },
                    child: Text("Register")),
                    // style: TextButton.styleFrom(
                    //   padding: EdgeInsets.symmetric(horizontal: 80),
                    //   backgroundColor: Colors.green.withOpacity(0.5)),


                      // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //     email: _emailTextController.text,
                      //     password: _passwordTextController.text)
                      //     .then((value) {
                      //   print("Created New Account");
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => ProfileScreen()));
                      // }).onError((error, stackTrace) {
                      //   print("Error ${error.toString()}");
                      // });

                  ],
                ),
              ))),
    );
  }
  Future popup() async {
    await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Anda telah didaftar.")));

  }
}