import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_akhir/main.dart';
import 'package:projek_akhir/ForgotPage.dart';
import 'package:projek_akhir/settingsPage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return homescreen();
  }
}

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;
  bool hasPimage = false;
  var firstName = "Loading..";
  var lastName = "";
  String profilePicLink = "";
  String displayCheckerText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkdocument();
    loadgambar();
    loadUserData();
  }

  void loadUserData() {
    _firestore.collection("users").doc("${user.email}").get().then((snapshot) {
      setState(() {
        firstName = snapshot.data()!["firstname"];
        lastName = snapshot.data()!["lastname"];
      });
    });
  }

  void checkdocument() {
    Reference ref = FirebaseStorage.instance.ref().child("${user.email}");
    ref.getDownloadURL().then((value) => hasPimage = true);
  }

  void loadgambar() async {
    Reference ref = FirebaseStorage.instance.ref().child("${user.email}");
    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    // final collection = FirebaseFirestore.instance.collection('users');

    return MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.purple)),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('MyKv Cafeteria'),
          ),
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log Masuk Sebagai :',
                  style: TextStyle(fontSize: 16),
                ),
                Center(
                  child: Text((user.email!),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  // SizedBox(height: 8),
                ),
                Text(user.uid),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Navigator.push(context, MaterialPageRoute(builder:(context) => settingsPage()));

                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.purple),
                  accountName: Text("${firstName + " " + lastName}"),
                  accountEmail: Text(user.email!),
                  currentAccountPicture: CircleAvatar(
                      child: Text(hasPimage == false
                          ? displayCheckerText = firstName[0] + lastName[0]
                          : displayCheckerText = ""),
                      backgroundImage: NetworkImage(profilePicLink)),
                ),

                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgot()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => settingsPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text("Contact Us"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.send_to_mobile_rounded),
                  title: Text("Log Out"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
