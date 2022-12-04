import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_akhir/color_utils.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        title: const Text("Forgot Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
    hexStringToColor("CB2B93"),
    hexStringToColor("9546C4"),
    hexStringToColor("5E61F4")
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
    ),child: Padding(
        padding: EdgeInsets.all(16),

      child: Form(child: Column(


        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Receive email to\n reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailcontroller,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (email) =>
            //     email != null && email.isNotEmpty ? 'Enter Valid Email' : null,
          ),
          SizedBox(height: 20),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            icon: Icon(Icons.email_outlined),
            label: Text(
                  'Reset Password',
              style: TextStyle(fontSize: 24),
            ),
              onPressed: resetPassword,
          ),
        ],
      ),
      )
    )
      ),
      // body: Padding(
      //     padding: EdgeInsets.all(16),
      //
      //   child: Form(,child: Column(
      //
      //
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('Receive email to\n reset your password',
      //         textAlign: TextAlign.center,
      //         style: TextStyle(fontSize: 24),),
      //       SizedBox(height: 20),
      //       TextFormField(
      //         controller: _emailcontroller,
      //         cursorColor: Colors.white,
      //         textInputAction: TextInputAction.done,
      //         decoration: InputDecoration(labelText: 'Email'),
      //         autovalidateMode: AutovalidateMode.onUserInteraction,
      //         // validator: (email) =>
      //         //     email != null && email.isNotEmpty ? 'Enter Valid Email' : null,
      //       ),
      //       SizedBox(height: 20),
      //     ElevatedButton.icon(
      //         style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
      //         icon: Icon(Icons.email_outlined),
      //         label: Text(
      //               'Reset Password',
      //           style: TextStyle(fontSize: 24),
      //         ),
      //           onPressed: resetPassword,
      //       ),
      //     ],
      //   ),
      //   )
      // )
    );
  }
  Future resetPassword() async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
      email: _emailcontroller.text).then((value) =>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("E-mel telah dihantar."))));

  }

}
// ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("E-mel telah dihantar!");