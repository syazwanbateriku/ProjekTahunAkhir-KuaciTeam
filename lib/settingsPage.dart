
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";
  String success = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance.ref().child("${user.email}");
    //
    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

      // Get reference to Firestore collection


    //   var doc = await collectionRef.document(docId).get();
    //   return doc.exists;
    // } catch (e) {
    //   throw e;
    // }

  // Future loading() async{
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //     return Center(child: CircularProgressIndicator());
  //       }
  //       );
  //   await profilePicLink == profilePicLink.isNotEmpty ?
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 24),
                height: 300,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: Center(
                  child: profilePicLink == "" ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 100,
                  ) : ClipRRect (
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(profilePicLink),
                  ),
                ),
              ),
            ),
            Center(child: Text(
                profilePicLink != ""?
                success = "Success upload profile pictures :)"
              : success = "??"),

            )

          ],
        ),
      ),
    );
  }
}