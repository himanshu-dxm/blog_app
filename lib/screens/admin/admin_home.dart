import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/user/home_screen.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  late String authorName,title;
  XFile? selectedImage;
  bool isLoading = false;
  CRUDMethods _crudMethods = new CRUDMethods();

  // Pick an image
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage=image;
    });
  }

  uploadBlog() async {
    await Firebase.initializeApp();
    if(selectedImage!=null) {
      setState(() {
        isLoading = true;
      });
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref = storage.ref().
      child("blogImage").
          child("${randomAlphaNumeric(9)}.jpg");
      var downloadUrl;
      try {
        await ref.putFile(File(selectedImage!.path));
        downloadUrl = await ref.getDownloadURL();
      } on firebase_storage.FirebaseException catch (e) {
        print(e);
      }
      // {firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.
      // ref().child("blogImage").
      // child("${randomAlphaNumeric(9)}.jpg");
      //
      // firebaseStorageRef.putFile(File(selectedImage!.path));
      // var downloadUrl = await firebaseStorageRef.getDownloadURL().then((_) {
      //
      // });}
      print("This is the url - <$downloadUrl>");
      Map<String,String> blogMap = {
        "authorName" : authorName,
        "title" : title,
        "imageURL" : downloadUrl
      };
      _crudMethods.addData(blogMap).then((value) {
        print("Uploading data");
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).
      showSnackBar(
          SnackBar(
              content: Text(
                  "Pick an Image First!!"
              )
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 22,
              ),
            ),
            Text(
              "Home",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              //TODO Signout system
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.logout_rounded),
            ),
          )
        ],
      ),
      body:(isLoading)?
      Container(
        child: Center(child:CircularProgressIndicator()),
      ):
      Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: (selectedImage!=null) ?
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.97,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                            File(selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    :
                    Container(
                      // padding: EdgeInsets.all(6),
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.97,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.add_a_photo_rounded,color: Colors.yellowAccent,),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: "Author Name"),
                          onChanged: (val) {
                            authorName = val;
                            // print(authorName);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    autofocus: true,
                    onPressed: ( ){
                      uploadBlog();
                      // isLoading = true;
                    },
                    child: Text("Upload")
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
