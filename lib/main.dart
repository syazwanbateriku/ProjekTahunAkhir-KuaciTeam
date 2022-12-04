import 'package:firebase_auth/firebase_auth.dart';
import 'package:projek_akhir/RegisterPage.dart';
import 'package:projek_akhir/color_utils.dart';
import 'package:projek_akhir/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projek_akhir/ForgotPage.dart';
import 'package:projek_akhir/helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    ); // MaterialApp
  }
}
//
// void main() async{
//
//   runApp( MaterialApp(
//       home: SignInScreen(),
//     ),
//   );
// }

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key,}) : super(key: key);


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Service service = Service();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body and key


      body: Form(

          key: formGlobalKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
             ),

          child: SingleChildScrollView(child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
    child: Column(
            children: <Widget>[
            const Text(
            "MyKv Cafeteria",
            style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
            const Text(
              "KV Port Dickson",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "release version alpha 1.0",
              style: TextStyle(
                color: Colors.green
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextFormField(

              decoration: const InputDecoration(icon: Icon(Icons.person),
                  labelText: 'E-mel *',),
                controller: _emailController,
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
                  labelText: 'Kata Laluan *',),obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value != null && value.length < 7) {
                  return 'Enter min. 7 characters';
                  }else{
                return null;
    }}
              ),

            // reusableTextField("Masukkan Kata Laluan", Icons.lock_outline, true,
            //     _passwordController),
            // const SizedBox(
            //   height: 5,
            // ),
            forgetPassword(context),
            ElevatedButton(
                child: const Text("Sign In"),
                onPressed: () {

                  if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                    {
                      service.loginUser(_emailController.text, _passwordController.text, context);
                    }else {
                    service.error(context, "Field tak boleh kosong");
                  }

                  // FirebaseAuth.instance.signInWithEmailAndPassword(
                  //     email: _emailController.text,
                  //     password: _passwordController.text)
                  //     .then((value) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => homescreen()));}



    // await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(
    // email: _emailController.text,
    // password: _passwordController.text,
    // );

                  }

    ),

            signUpOption()
            ],
          ),
          ),

      ),
    )
      ),

          );


    }






  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Forgot()));}
      ),
    );



  }
}