
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/admin/admin_login.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/utils/CommonUtils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CRUDMethods _crudMethods = new CRUDMethods();
   var blogSnapshot;

  @override
  void initState() {
    super.initState();
    initialSetups();
  }
  initialSetups() async {
    await Firebase.initializeApp();
    _crudMethods.getData().then((value) {
      blogSnapshot = value;
      setState(() {
        // blogSnapshot = value;
      });
    });
  }


  Widget BlogList() {
    return Container(
      child: (blogSnapshot!=null)?
      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: blogSnapshot.docs.length,
            itemBuilder: (context,index) {
              return BlogTile(
                  authorName: blogSnapshot.docs[index].get("authorName"),
                  title: blogSnapshot.docs[index].get("title"),
                  imageURL: blogSnapshot.docs[index].get("imageURL")
              );
            }
          ),
          SizedBox(height: 8,),
        ],
      ):
      Container(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonUtils.myAppBar("Flutter","Blog"),

      body: BlogList(),

      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLogin())
                  );
                },
              child: Icon(Icons.verified_user),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // const BlogTile({Key? key}) : super(key: key);
  String authorName, title, imageURL;
  BlogTile({required this.authorName,required this.title,required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              imageURL,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: Center(child: Text(title))),
                SizedBox(height: 8,),
                Container(child: Center(child: Text(authorName))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

