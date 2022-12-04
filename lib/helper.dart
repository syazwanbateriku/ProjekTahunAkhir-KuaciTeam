

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_akhir/ProfileScreen.dart';

class Service {
  final auth = FirebaseAuth.instance;

  createUser(email, password, context) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      error(context, e);
    }
  }

  loginUser(email, password, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      });
    } catch (e) {
      error(context, e);
    }
  }



  error(context, e) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(e.toString().split("]").last),

      );
    }
    );

  }

}


