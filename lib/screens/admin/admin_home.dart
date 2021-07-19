import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/CommonUtils.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  late String authorName,title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    // padding: EdgeInsets.all(6),
                    height: 200,
                    width: MediaQuery.of(context).size.width*0.97,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Icon(Icons.add_a_photo_rounded,color: Colors.yellowAccent,),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: "Name"),
                          onChanged: (val) {
                            authorName = val;
                            print(authorName);
                          },
                        ),
                      ],
                    ),
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
